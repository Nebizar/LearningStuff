bot_template = "BOT : {0}"
user_template = "USER : {0}"

# Import the random module
import random

name = "Greg"
weather = "cloudy"

# Define a dictionary containing a list of responses for each message
responses = {
  "what's your name?": [
      "my name is {0}".format(name),
      "they call me {0}".format(name),
      "I go by {0}".format(name)
   ],
  "what's today's weather?": [
      "the weather is {0}".format(weather),
      "it's {0} today".format(weather)
    ],
  "default": ["default message"]
}

responses2={
"question":[
      "I don't know",
      "You tell me"
  ],
  "statements":[
       'tell me more!',
       'why do you think that?',
       'how long have you felt this way?',
        'I find that extremely interesting',
        'can you back that up?',
        'oh wow!',
        ':)'
  ]
}

# Use random.choice() to choose a matching response
def respond(message):
    # Check if the message is in the responses
    if message in responses:
        # Return a random matching response
        bot_message = random.choice(responses[message])
    else:
        if message.endswith('?'):
            bot_message = random.choice(responses2["question"])
        else:
            # Return a random "default" response
            bot_message = random.choice(responses2["statements"])
    return bot_message

def send_message(message):
    # Print user_template including the user_message
    print(user_template.format(message))
    # Get the bot's response to the message
    response = respond(message)
    # Print the bot template including the bot's response.
    print(bot_template.format(response))

