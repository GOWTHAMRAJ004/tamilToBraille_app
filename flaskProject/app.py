from flask import Flask, request, jsonify, render_template
import random


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

    # Braille mappings
    braille_map = {
        '⠁': 'அ',
        '⠜': 'ஆ',
        '⠊': 'இ',
        '⠔': 'ஈ',
        '⠥': 'உ',
        '⠳': 'ஊ',
        '⠢': 'எ',
        '⠑': 'ஏ',
        '⠌': 'ஐ',
        '⠭': 'ஒ',
        '⠕': 'ஓ',
        '⠪': 'ஔ',
        '⠅': 'க',
        '⠬': 'ங',
        '⠉': 'ச',
        '⠒': 'ஞ',
        '⠾': 'ட',
        '⠼': 'ண',
        '⠞': 'த',
        '⠝': 'ந',
        '⠏': 'ப',
        '⠍': 'ம',
        '⠽': 'ய',
        '⠗': 'ர',
        '⠇': 'ல',
        '⠧': 'வ',
        '⠷': 'ழ',
        '⠸': 'ள',
        '⠻': 'ற',
        '⠰': 'ன',
        '⠚': 'ஜ',
        '⠯': 'ஷ',
        '⠎': 'ஸ',
        '⠓': 'ஹ',
        '⠈': '்',
        '⠠': 'ஃ',
        '⠜': 'ா',
        '⠊': 'ி',
        '⠔': 'ீ',
        '⠥': 'ு',
        '⠳': 'ூ',
        '⠢': 'ெ',
        '⠑': 'ே',
        '⠌': 'ை',
        '⠭': 'ொ',
        '⠪': 'ோ',
        '⠂': ',',
        '⠆': ';',
        '⠒': ':',
        '⠖': '!',
        '⠦': '?',
        '⠲': '.'
    }

    # Function to generate a random question
    def generate_question():
        braille_representation = random.choice(list(braille_map.keys()))
        tamil_char = braille_map[braille_representation]
        return braille_representation, tamil_char

    # Route for the home page
    @app.route('/')
    def index():
        return render_template('index.html')

    # Route to start and play the game
    @app.route('/play_game', methods=['GET', 'POST'])
    def play_game():
        if request.method == 'POST':
            # Get player's answer from the form
            player_answer = request.form['answer']

            # Generate a random question
            braille_representation, correct_answer = generate_question()

            # Check if the answer is correct
            if player_answer == correct_answer:
                result = "Correct!"
            else:
                result = f"Wrong! The correct answer is '{correct_answer}'."

            return render_template('play_game.html', question=braille_representation, result=result)

        return render_template('play_game.html', question=None, result=None)



if __name__ == '__main__':
    app.run(debug=True)