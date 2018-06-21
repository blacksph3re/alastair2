import json

content = ""
with open('ingredients', 'r') as content_file:
    content = content_file.read()

content = json.loads(content)
content = content["meals"]

ingredients = [{"name": i["strIngredient"], "description": i["strDescription"]} for i in content]



with open('parsed.json', "w") as output_file:
  output_file.write(json.dumps(ingredients))
  output_file.close()