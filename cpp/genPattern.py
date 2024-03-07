import random

def genString():
  n = random.randint(1, 5)
  s = ""
  for i in range(n):
    s += chr(random.randint(97, 122))
  
  return s


output_s = ""
for i in range(100):
  nested_n = random.randint(1, 20)

  # generate XML format string, xmlString
  contents = []
  xmlString = ""
  for i in range(nested_n):
    contents.append(genString())

  valid = True
  if random.randint(0, 10) < 5:
    valid = False

  for i in range(nested_n):
    temp = f'<{contents[i]}>'
    if not valid:
      changeLoc = random.randint(0, len(temp)-1)
      oldStr = temp
      newStr = oldStr
      while oldStr == newStr:
        newStr = chr(random.randint(97, 122))
      temp = temp[:changeLoc] + newStr + temp[changeLoc+1:]

    xmlString += temp

    xmlString += genString()
  for i in range(nested_n-1, -1, -1):
    xmlString += f'</{contents[i]}>'

  if valid:
    PatternCmd = f'test "{xmlString}" "Valid"'
  else:
    PatternCmd = f'test "{xmlString}" "Invalid"'
  output_s += f'{PatternCmd}\n'

with open("test_cmd_pattens.txt", "w") as f:
  f.write(output_s)

