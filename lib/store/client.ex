defmodule Store.Client do
    use Ecto.Schema

    schema "clients" do
      field :name, :string, size: 64
      field :city, :string, size: 24
      field :gender, :string, size: 1
      field :birthday, :date
      field :phone, :string, size: 16
      field :discount, :integer
      has_many :order, Store.Order
      timestamps()
    end
  end
