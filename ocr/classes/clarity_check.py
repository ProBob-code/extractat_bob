##### Working code #####

import cv2
import numpy as np
# Removed unused pytesseract import

# Threshold for blur detection
BLUR_THRESHOLD = 200.0  # Adjust this value based on your requirements


class ClarityCheck:

    @staticmethod
    def detect_blur(image):
        """
        Detects if the image is blurry using multiple methods:
        - Laplacian variance
        - Gaussian blur detection
        - Fourier transform analysis
        
        Args:
            image (numpy.ndarray): The input image.
        
        Returns:
            bool: True if the image is blurry, False otherwise.
            dict: A dictionary containing the results of each method and the final decision.
        """
        # Convert the image to grayscale
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        
        # Method 1: Laplacian Variance
        laplacian_var = cv2.Laplacian(gray, cv2.CV_64F).var()
        laplacian_blurry = laplacian_var < BLUR_THRESHOLD

        # Method 2: Gaussian Blur Detection
        blurred = cv2.GaussianBlur(gray, (9, 9), 0)  # Apply Gaussian blur
        diff = cv2.absdiff(gray, blurred)  # Compute the absolute difference
        mean_diff = np.mean(diff)  # Calculate the mean difference
        gaussian_blurry = mean_diff < 10  # Threshold for Gaussian blur detection

        # Method 3: Fourier Transform Analysis
        dft = cv2.dft(np.float32(gray), flags=cv2.DFT_COMPLEX_OUTPUT)  # Compute the DFT
        dft_shift = np.fft.fftshift(dft)  # Shift the zero frequency component to the center
        magnitude_spectrum = 20 * np.log(cv2.magnitude(dft_shift[:, :, 0], dft_shift[:, :, 1]) + 1)
        high_freq_energy = np.sum(magnitude_spectrum > 10)  # Count high-frequency components
        fourier_blurry = high_freq_energy < 1000  # Threshold for Fourier transform analysis

        # Combine results from all methods
        blurry_methods = [laplacian_blurry, gaussian_blurry, fourier_blurry]
        is_blurry = sum(blurry_methods) >= 2  # Majority voting: at least 2 methods must agree

        # Return the results
        results = {
            "is_blurry": is_blurry,
            "laplacian_var": laplacian_var,
            "laplacian_blurry": laplacian_blurry,
            "mean_diff": mean_diff,
            "gaussian_blurry": gaussian_blurry,
            "high_freq_energy": high_freq_energy,
            "fourier_blurry": fourier_blurry
        }
        return is_blurry, results