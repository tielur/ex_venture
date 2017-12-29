defmodule Data.Mail do
  @moduledoc """
  Mail schema
  """

  use Data.Schema

  alias Data.User

  schema "mail" do
    field :title, :string
    field :body, :string

    belongs_to :sender, User
    belongs_to :receiver, User

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:title, :body, :sender_id, :receiver_id])
    |> validate_required([:title, :sender_id, :receiver_id])
    |> foreign_key_constraint(:sender_id)
    |> foreign_key_constraint(:receiver_id)
  end
end
