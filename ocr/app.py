from flask import Flask, request, jsonify
import cv2
import numpy as np
import requests
from classes.clarity_check import ClarityCheck
from werkzeug.utils import secure_filename
import os
from classes.text_extractor import TextExtractor


app = Flask(__name__)

@app.route('/detect_blur', methods=['POST'])
def detect_blur():
    """
    API endpoint to detect if an image is blurry.
    Accepts either:
    - A local file path (via 'local_path' in the JSON body)
    - An image URL (via 'img_url' in the JSON body)
    - An uploaded image file (via 'image' in the form data)
    """
    image = None

    # Check if 'image' file is provided in the request
    if 'image' in request.files:
        # Read the image file from the request
        image_file = request.files['image']
        image_data = np.frombuffer(image_file.read(), np.uint8)
        image = cv2.imdecode(image_data, cv2.IMREAD_COLOR)

    # Check if 'local_path' is provided in the JSON body
    elif request.json and 'local_path' in request.json:
        local_path = request.json['local_path']
        try:
            image = cv2.imread(local_path)
            if image is None:
                return jsonify({"error": f"Could not read image from local path: {local_path}"}), 400
        except Exception as e:
            return jsonify({"error": f"Error reading image from local path: {str(e)}"}), 400

    # Check if 'img_url' is provided in the JSON body
    elif request.json and 'img_url' in request.json:
        img_url = request.json['img_url']
        try:
            response = requests.get(img_url, stream=True)
            if response.status_code != 200:
                return jsonify({"error": f"Failed to download image from URL: {img_url}"}), 400
            image_data = np.asarray(bytearray(response.content), dtype=np.uint8)
            image = cv2.imdecode(image_data, cv2.IMREAD_COLOR)
        except Exception as e:
            return jsonify({"error": f"Error downloading image from URL: {str(e)}"}), 400

    # If no valid input is provided
    else:
        return jsonify({"error": "No valid input provided. Provide 'image', 'local_path', or 'img_url'."}), 400

    # If the image is still None, return an error
    if image is None:
        return jsonify({"error": "Invalid image file"}), 400

    # Call the ClarityCheck class to detect blur
    is_blurry, results = ClarityCheck.detect_blur(image)

    # Ensure all values in the results dictionary are JSON serializable
    results = {key: (int(value) if isinstance(value, np.integer) else
                     float(value) if isinstance(value, np.floating) else
                     bool(value) if isinstance(value, np.bool_) else value)
               for key, value in results.items()}

    # Check if 'details' parameter is set to 1
    include_details = request.json.get('details', 0) == 1

    # Prepare the response
    response = {
        "is_blurry": bool(is_blurry)  # Ensure is_blurry is JSON serializable
    }
    if include_details:
        response["details"] = results

    # Return the response as JSON
    return jsonify(response)

import logging

logging.basicConfig(level=logging.DEBUG)

@app.route('/extract-text', methods=['POST'])
def extract_text():
    try:
        logging.debug("Request received: %s", request.json or request.form or request.files)

        # Initialize a list to store results for multiple images
        results = []

        # Check if the request contains multiple local paths
        if request.json and 'local_paths' in request.json:
            logging.debug("Processing multiple local paths")
            for local_path in request.json['local_paths']:
                if not os.path.isfile(local_path):
                    logging.error("Local file not found: %s", local_path)
                    results.append({"error": f"Local file not found: {local_path}"})
                    continue

                image_name = os.path.basename(local_path)
                # Process the image
                result = process_image(local_path, image_name)
                results.append(result)

        # Check if the request contains multiple URLs
        if request.json and 'urls' in request.json:
            logging.debug("Processing multiple URLs")
            for image_url in request.json['urls']:
                try:
                    response = requests.get(image_url, stream=True)
                    if response.status_code != 200:
                        logging.error("Failed to download image from URL: %s", image_url)
                        results.append({"error": f"Failed to download image from URL: {image_url}"})
                        continue

                    image_name = os.path.basename(image_url)
                    image_path = os.path.join('/tmp', image_name)
                    with open(image_path, 'wb') as f:
                        f.write(response.content)

                    # Process the image
                    result = process_image(image_path, image_name)
                    results.append(result)

                except Exception as e:
                    logging.error("Error downloading image from URL: %s", str(e))
                    results.append({"error": f"Error downloading image from URL: {str(e)}"})

        # If no valid input is provided
        if not results:
            logging.error("No valid local_paths or URLs provided")
            return jsonify({"error": "No valid local_paths or URLs provided"}), 400

        # Return the results for all images
        return jsonify(results)

    except requests.exceptions.RequestException as e:
        logging.error("Request error: %s", str(e))
        return jsonify({"error": f"Request error: {str(e)}"}), 400
    except Exception as e:
        logging.error("Internal server error: %s", str(e))
        return jsonify({"error": f"Internal server error: {str(e)}"}), 500


def process_image(image_path, image_name):
    """
    Process a single image: extract and correct text, and format the results.
    """
    try:
        # Read the image
        img = cv2.imread(image_path)
        if img is None:
            logging.error("Failed to read the image: %s", image_path)
            return {"error": f"Failed to read the image: {image_name}"}

        # Extract and correct text
        combined_extracted_text, corrected_text = TextExtractor.extract_and_correct_text(image_path)

        if combined_extracted_text is None:
            logging.error("Text extraction failed: %s", corrected_text)
            return {"error": corrected_text}

        # Format the results
        response = TextExtractor.format_ocr_results(
            image_name=image_name,
            extracted_text=combined_extracted_text,
            corrected_text=corrected_text
        )

        return response

    except Exception as e:
        logging.error("Error processing image: %s", str(e))
        return {"error": f"Error processing image: {str(e)}"}
    
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)