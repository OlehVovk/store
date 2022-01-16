defmodule Store.Repo.Migrations.AddConstraints do
  use Ecto.Migration

  def up do
    # makers
    alter table("makers") do
      add :itn, :string, size: 10, null: false
      modify :name, :string, size: 64, null: false
    end

    create unique_index("makers", [:itn])
    # -------------------------------------------------------
    # clients
    alter table("clients") do
      modify :name, :string, size: 64, null: false
      modify :city, :string, size: 24, null: false
      modify :phone, :string, size: 16, null: false
    end

    # -------------------------------------------------------
    # orders

    alter table("orders") do
      add :order_number, :integer, null: false
      modify :orderdata, :date, null: false
      modify :shiptype, :string, size: 24, null: false
      modify :shipcity, :string, size: 24, null: false
      modify :shipcost, :decimal, null: false
    end

    # -------------------------------------------------------
    # changing primary key in "products"
    drop(constraint("order_basket", "order_basket_product_id_fkey"))
    drop(constraint("products", "products_pkey"))

    alter table("products") do
      modify :name, :string, size: 32, primary_key: true
      modify :price, :decimal, primary_key: true
    end

    create unique_index("products", [:id])
    # -------------------------------------------------------
    # order_basket
    alter table("order_basket") do
      modify :quantity, :integer, null: false
      modify :product_id, references("products", on_delete: :delete_all, on_update: :update_all)
    end

    create unique_index("order_basket", [:order_id, :product_id])
    # -------------------------------------------------------
  end

  def down do
    # changing primary key in "products"
    drop(constraint("order_basket", "order_basket_product_id_fkey"))
    drop index("products", [:id])
    drop(constraint("products", "products_pkey"))

    alter table("products") do
      modify :id, :integer, primary_key: true
      modify :name, :string, size: 32, null: true
      modify :price, :decimal, null: true
    end

    # -------------------------------------------------------
    # order_basket
    drop index("order_basket", [:order_id, :product_id])

    alter table("order_basket") do
      modify :quantity, :integer, null: true
      modify :product_id, references("products", on_delete: :delete_all, on_update: :update_all)
    end

    # -------------------------------------------------------
    # orders
    alter table("orders") do
      remove :order_number
      modify :orderdata, :date, null: true
      modify :shiptype, :string, size: 24, null: true
      modify :shipcity, :string, size: 24, null: true
      modify :shipcost, :decimal, null: true
    end

    # -------------------------------------------------------
    # clients
    alter table("clients") do
      modify :name, :string, size: 64, null: true
      modify :city, :string, size: 24, null: true
      modify :phone, :string, size: 16, null: true
    end

    # -------------------------------------------------------
    # makers
    alter table("makers") do
      remove :itn
      modify :name, :string, size: 64
    end

    # -------------------------------------------------------
  end
end
