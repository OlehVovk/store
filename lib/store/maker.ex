defmodule Store.Maker do
  use Ecto.Schema

  schema "makers" do
    field :name, :string, size: 64
    field :country, :string, size: 64
    has_many :product, Store.Product
    timestamps()
  end
end
