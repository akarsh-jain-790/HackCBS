from flask import Flask, jsonify
import random

app = Flask(__name__)

# Sample list of daily challenges (you can replace this with your actual data)
daily_challenges = [
    "Plant a tree in your local park",
    "Identify and learn about a new plant species",
    "Create a mini herb garden on your windowsill",
    "Go for a nature walk and document your findings",
    "Find and photograph the greenest lawn in your neighborhood.",
    "Identify and learn about a unique type of grass in your local park.",
    "Create a piece of grass art using blades of grass as your canvas.",
    "Capture a macro photo of dewdrops on grass early in the morning.",
    "Participate in a local environmental cleanup and share your contribution.",
    "Encourage others to join you in a local park clean-up and share your progress."
]

# Route for getting a daily challenge
@app.route('/get_daily_challenge', methods=['GET'])
def get_daily_challenge():
    # Randomly select a daily challenge from the list
    challenge = random.choice(daily_challenges)

    return jsonify({"challenge": challenge})

if __name__ == '__main__':
    app.run(debug=True)
