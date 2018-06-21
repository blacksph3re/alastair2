defmodule Alastair.Seeds.ProductionSeed do
  def run() do
    Alastair.Seeds.CurrencySeed.run()
    Alastair.Seeds.MeasurementSeed.run()
    Alastair.Seeds.IngredientFileSeed.run()
  end
end