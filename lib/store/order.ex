defmodule Store.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:client_id, :order_number, :orderdata, :shiptype, :shipcity, :shipcost]

  schema "orders" do
    belongs_to :client, Store.Client
    field :order_number, :integer

    # TODO создать автогенерацию :order_number, autogenerate: true в миграции не сработал
    field :orderdata, :date
    field :donedata, :date
    field :shiptype, :string, size: 24
    field :shipcity, :string, size: 24
    field :shipcost, :decimal
    timestamps()
  end

  def changeset(%__MODULE__{} = order, attrs) do
    order
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> validate_inclusion(:shiptype, ["mail", "self", "urgent"])
  end
end
