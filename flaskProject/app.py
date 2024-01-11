from flask import Flask, request, jsonify

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



@app.route('/tamil-to-braille', methods=['POST'])
def convert_tamil_to_braille():
    data = request.json
    user_input = data.get('text')
    braille_output = tamil_to_braille(user_input)
    return jsonify({'braille': braille_output})

@app.route('/braille-to-tamil', methods=['POST'])
def convert_braille_to_tamil():
    data = request.json
    user_input = data.get('text')
    tamil_output = braille_to_tamil(user_input)
    return jsonify({'tamil': tamil_output})
@app.route('/tests', methods=['GET'])
def test():
    if request.method == "GET":
        return jsonify({"response" : "he you where checked"})

if __name__ == '__main__':
    app.run(debug=True)