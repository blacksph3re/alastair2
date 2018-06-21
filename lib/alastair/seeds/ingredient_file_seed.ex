defmodule Alastair.Seeds.IngredientFileSeed do
  def run() do
    measurements = Alastair.Repo.all(Alastair.Measurement)
    file = File.read!("crawl/annotated.json")
    data = Poison.decode!(file)
    |> Enum.map(fn(ing) -> 
      meas = Enum.find(measurements, nil, fn(x) -> x.display_code == ing["measurement"] end)
      Alastair.Repo.insert!(%Alastair.Ingredient{
        name: ing["name"],
        description: ing["description"],
        default_measurement: meas
      })
    end)
  end
end