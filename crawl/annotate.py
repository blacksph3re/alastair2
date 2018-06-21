import json

content = ""
with open('annotated.json', 'r') as content_file:
    content = content_file.read()

content = json.loads(content)

content = sorted(content, key = lambda x: x["name"])

for ing in content:
  if("measurement" in ing.keys()):
    continue
  print(ing["name"])
  meas = input("1 - ml, 2 - g, 3 - pc. 4- ignore\n")
  if(meas == 1 or meas == "1"):
    ing["measurement"] = "ml"
  elif(meas == 2 or meas == "2"):
    ing["measurement"] = "g"
  elif(meas == 3 or meas == "3"):
    ing["measurement"] = "pc"    
  elif(meas == 4 or meas == "4"):
    ing["filter"] = 1
  else:
    break

content = [x for x in content if not("filter" in x.keys())]



with open('annotated.json', "w") as output_file:
  output_file.write(json.dumps(content))
  output_file.close()