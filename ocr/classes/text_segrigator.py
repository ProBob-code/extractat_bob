####### Working code #######

import pandas as pd
import re


class TextSegrigator:
    
    def __init__(self, df):
        self.df = df

    def clean_corrected_text(text):
        """Remove unwanted prefixes and suffixes from corrected text."""
        # Remove common prefixes
        prefixes = [
            "Here is the corrected text with proper grammar, structure, and address formatting:",
            "Here is the corrected text:",
            "I made the following corrections:",
            "Here is the corrected version of the text: ",
            "Here's the corrected text with proper grammar, structure, and address: ",
        ]
        
        # Remove the text content after "I made the following corrections:"
        if "I made the following corrections:" in text:
            text = text.split("I made the following corrections:")[0]
        
        # Remove prefixes
        for prefix in prefixes:
            if text.startswith(prefix):
                text = text.replace(prefix, "")
        
        return text.strip()

    def extract_fields(text):
        """Extract specific fields from the corrected text."""
        fields = {
            'Name': '',
            'Designation': '',
            'Company_Name': '',
            'Address': '',
            'Phone': '',
            'Mobile': '',
            'Email': '',
            'Website': '',
            'Fax': ''
        }
        
        # Extract Name
        name_pattern = r'\b[A-Z][a-z]+\s[A-Z][a-z]+\b'
        names = re.findall(name_pattern, text)
        fields['Name'] = names[0] if names else ''
        
        # Extract Designation
        designation_pattern = r'\b(?:Director|General Manager - IT|CEO|CTO|Founder|Owner|Partner|Associate|Analyst|Engineer|Developer|Lead|Head|President|Vice President|Consultant|Specialist|Executive|Officer|Supervisor|Administrator|Sales Manager|Manager Enterprises|Assistant Manager|Product Manager)\b'
        designations = re.findall(designation_pattern, text, re.IGNORECASE)
        fields['Designation'] = ', '.join(set(designations))  # Use `set` to avoid duplicates
        
        # Extract Company Name
        company_pattern = r'[A-Z][a-zA-Z\s]+(?:Ltd|Inc|Corp|LLC|Limited|Pvt\. Ltd\.|Technoplast)'
        companies = re.findall(company_pattern, text)
        fields['Company_Name'] = companies[0] if companies else ''
        
        # Extract Address
        address_pattern = r'\d{1,4}\s[A-Za-z0-9\s,.-]+(?:[A-Za-z]+\s\d{6})?'
        addresses = re.findall(address_pattern, text)
        fields['Address'] = addresses[0] if addresses else ''
        
        # Extract Phone Number
        phone_pattern = r'[\+]?[(]?[0-9]{2,3}[)]?[-\s\.]?[0-9]{3,4}[-\s\.]?[0-9]{4,5}'
        phones = re.findall(phone_pattern, text)
        fields['Phone'] = ', '.join(phones)
        
        # Extract Email
        email_pattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
        emails = re.findall(email_pattern, text)
        fields['Email'] = emails[0] if emails else ''
        
        # Extract Website
        website_pattern = r'(?:https?://)?(?:www\.)?[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'
        websites = re.findall(website_pattern, text)
        fields['Website'] = websites[0] if websites else ''
        
        return fields

    def is_text_meaningful(fields):
        """Check if the extracted fields contain meaningful information."""
        # Check if any of the key fields have meaningful data
        key_fields = ['Name', 'Designation', 'Company_Name', 'Address', 'Phone', 'Email']
        for field in key_fields:
            if fields[field]:  # If any key field is not empty
                return True
        return False

# Read the CSV file
df = pd.read_csv('ocr_results_new_3.csv', sep=',')

# Process each corrected text
structured_data = []
for _, row in df.iterrows():
    # Clean the corrected text
    cleaned_text = TextSegrigator.clean_corrected_text(row['corrected_text'])
    
    # Extract fields
    fields = TextSegrigator.extract_fields(cleaned_text)
    
    # Check if the text is meaningful
    if TextSegrigator.is_text_meaningful(fields):
        # Add image name to fields
        fields['image_name'] = row['image_name']
        structured_data.append(fields)
    else:
        # If not meaningful, add a placeholder response
        structured_data.append({
            'image_name': row['image_name'],
            'Name': 'Re-upload the image with better clarity',
            'Designation': '',
            'Company_Name': '',
            'Address': '',
            'Phone': '',
            'Mobile': '',
            'Email': '',
            'Website': '',
            'Fax': ''
        })

# Create new DataFrame with structured data
result_df_4 = pd.DataFrame(structured_data)

# # Reorder columns
# columns_order = ['image_name', 'Name', 'Designation', 'Company_Name', 'Address', 
#                 'Phone', 'Mobile', 'Email', 'Website', 'Fax']
# result_df_4 = result_df_4[columns_order]

# # Save to new CSV
# result_df_4.to_csv('structured_business_cards_4.csv', index=False)

# # Display the results
# print("\nStructured Business Card Data:")
# print(result_df_4)