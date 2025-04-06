from flask import Flask, request, jsonify, render_template
import random
import cv2
import pytesseract
from PIL import Image
import pdf2image
import os
import PyPDF2
from fpdf import FPDF
from tkinter import Tk
from tkinter.filedialog import askopenfilename


app = Flask(__name__)

# Braille map for Tamil
braille_map = {
    'அ': '⠁',
    'ஆ': '⠜',
    'இ': '⠊',
    'ஈ': '⠔',
    'உ': '⠥',
    'ஊ': '⠳',
    'எ': '⠢',
    'ஏ': '⠑',
    'ஐ': '⠌',
    'ஒ': '⠭',
    'ஓ': '⠕',
    'ஔ': '⠪',
    'க': '⠅',
    'ங': '⠬',
    'ச': '⠉',
    'ஞ': '⠒',
    'ட': '⠾',
    'ண': '⠼',
    'த': '⠞',
    'ந': '⠝',
    'ப': '⠏',
    'ம': '⠍',
    'ய': '⠽',
    'ர': '⠗',
    'ல': '⠇',
    'வ': '⠧',
    'ழ': '⠷',
    'ள': '⠸',
    'ற': '⠻',
    'ன': '⠰',
    'ஜ': '⠚',
    'ஷ': '⠯',
    'ஸ': '⠎',
    'ஹ': '⠓',
    '்': '⠈',
    'ஃ': '⠠',
    'ா': '⠜',
    'ி': '⠊',
    'ீ': '⠔',
    'ு': '⠥',
    'ூ': '⠳',
    'ெ': '⠢',
    'ே': '⠑',
    'ை': '⠌',
    'ொ': '⠭',
    'ோ': '⠪',
    'ௌ': '⠪',
    ' ': ' ',
    ',': '⠂',
    ';': '⠆',
    ':': '⠒',
    '!': '⠖',
    '?': '⠦',
    '.': '⠲'
}

# Num map for Braille
num_map = {
    '0': '⠚',
    '1': '⠁',
    '2': '⠃',
    '3': '⠉',
    '4': '⠙',
    '5': '⠑',
    '6': '⠋',
    '7': '⠛',
    '8': '⠓',
    '9': '⠊'
}

def tamil_to_braille(text):
    braille = ""
    for letter in text:
        braille += braille_map.get(letter, letter)
    return braille

def braille_to_tamil(text):
    tamil_vowels = ['அ', 'ஆ', 'இ', 'ஈ', 'உ', 'ஊ', 'எ', 'ஏ', 'ஐ', 'ஒ', 'ஓ', 'ஔ']
    tamil = ""
    for i in range(len(text)):
        letter = text[i]
        if letter == "⠼":
            i += 1
            letter = text[i]
            for k, v in num_map.items():
                if v == letter:
                    tamil += k
                    break
            continue
        for k, v in braille_map.items():
            if v == letter:
                if k in tamil_vowels:
                    if i == 0 or text[i-1] == ' ':
                        tamil += k
                        break
                else:
                    tamil += k
                    break
    return tamil

def read_text_from_pdf(file_path):
    with open(file_path, 'rb') as file:
        pdf_reader = PyPDF2.PdfReader(file)
        text = ''
        for page_num in range(len(pdf_reader.pages)):
            page = pdf_reader.pages[page_num]
            text += page.extract_text()
        return text

def convert_Tamil_to_braille(tamil_text):
    braille_text = ''
    for char in tamil_text:
        if char in braille_map:
            braille_text += braille_map[char]
        elif char.isdigit():
            braille_text += num_map[char]
        else:
            braille_text += char
    return braille_text

def save_braille_as_pdf(braille_text):
    pdf_output_path = os.path.join(os.path.expanduser('~'), 'Downloads', 'braille_output.pdf')
    pdf = FPDF()
    pdf.add_page()
    pdf.set_font("Arial", size=12)
    pdf.multi_cell(0, 10, braille_text)
    pdf.output(pdf_output_path)
    return pdf_output_path



# Set the path to Tesseract executable (change it based on your installation)
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'

# Set the language to Tamil
lang = 'tam'

# Set the path to the Tesseract data files (change it based on your installation)
os.environ['TESSDATA_PREFIX'] = r'C:\Program Files\Tesseract-OCR\tessdata'

# Tamil Braille mappings
tamil_braille_map = {
    'அ': '⠁', 'ஆ': '⠜', 'இ': '⠊', 'ஈ': '⠔', 'உ': '⠥', 'ஊ': '⠳', 'எ': '⠢', 'ஏ': '⠑',
    'ஐ': '⠌', 'ஒ': '⠭', 'ஓ': '⠕', 'ஔ': '⠪', 'க': '⠅', 'ங': '⠬', 'ச': '⠉', 'ஞ': '⠒',
    'ட': '⠾', 'ண': '⠼', 'த': '⠞', 'ந': '⠝', 'ப': '⠏', 'ம': '⠍', 'ய': '⠽', 'ர': '⠗',
    'ல': '⠇', 'வ': '⠧', 'ழ': '⠷', 'ள': '⠸', 'ற': '⠻', 'ன': '⠰', 'ஜ': '⠚', 'ஷ': '⠯',
    'ஸ': '⠎', 'ஹ': '⠓', '்': '⠈', 'ஃ': '⠠', 'ா': '⠜', 'ி': '⠊', 'ீ': '⠔', 'ு': '⠥',
    'ூ': '⠳', 'ெ': '⠢', 'ே': '⠑', 'ை': '⠌', 'ொ': '⠭', 'ோ': '⠪', 'ௌ': '⠪', ' ': ' ',
    ',': '⠂', ';': '⠆', ':': '⠒', '!': '⠖', '?': '⠦', '.': '⠲'
}

def convert_to_tamils_braille(tamil_text):
    return ''.join([tamil_braille_map.get(char, char) for char in tamil_text])

@app.route('/image-to-braille', methods=['POST'])
def image_to_braille():
    try:
        # Check if the POST request has the file part
        if 'file' not in request.files:
            return jsonify({'error': 'No file part'}), 400

        file = request.files['file']

        # Check if the file is empty
        if file.filename == '':
            return jsonify({'error': 'No selected file'}), 400

        # Save the received file
        file_path = os.path.join('uploads', file.filename)
        file.save(file_path)

        # Read text from the image using Tesseract OCR
        img = cv2.imread(file_path)
        gray_image = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        text = pytesseract.image_to_string(gray_image, lang=lang)

        # Convert Tamil text to Braille
        tamil_braille_text = convert_to_tamils_braille(text)

        return jsonify({'tamil_text': text, 'braille_text': tamil_braille_text})

    except Exception as e:
        return jsonify({'error': str(e)}), 500


@app.route('/pdf-to-braille', methods=['POST'])
def pdf_to_braille():
    try:
        # Receive PDF file from Flutter app
        file = request.files['pdf']

        # Save the received PDF file
        file_path = os.path.join(os.path.expanduser('~'), 'Downloads', 'input.pdf')
        file.save(file_path)

        # Read text from PDF
        tamil_text = read_text_from_pdf(file_path)

        # Convert Tamil text to Braille
        braille_text = convert_Tamil_to_braille(tamil_text)

        # Save Braille as PDF and get the path
        pdf_output_path = save_braille_as_pdf(braille_text)

        return jsonify({'braille_pdf_path': pdf_output_path})

    except Exception as e:
        return jsonify({'error': str(e)}), 400

@app.route('/tamil-to-braille', methods=['GET'])
def convert_tamil_to_braille():
    user_input = request.args.get('text')
    if user_input:
        braille_output = tamil_to_braille(user_input)
        return jsonify({'braille': braille_output})
    else:
        return jsonify({'error': 'Missing text parameter'}), 400

@app.route('/braille-to-tamil', methods=['GET'])
def convert_braille_to_tamil():
    user_input = request.args.get('text')
    if user_input:
        tamil_output = braille_to_tamil(user_input)
        return jsonify({'tamil': tamil_output})
    else:
        return jsonify({'error': 'Missing text parameter'}), 400
@app.route('/tests', methods=['GET'])
def test():
    if request.method == "GET":
        return jsonify({"response" : "he you where checked"})




if __name__ == '__main__':
    if not os.path.exists('uploads'):
        os.makedirs('uploads')
    app.run(debug=True)