# Convert message propertly
with open("message.txt", "r") as m:
    lines = m.readlines()
    lines = [l[:-1] for l in lines]
    message = " ".join(lines)
    message = message.lower()
    print(message)
    print(len(message))