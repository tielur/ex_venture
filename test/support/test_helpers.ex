defmodule TestHelpers do
  alias Data.Repo
  alias Data.Class
  alias Data.Config
  alias Data.Item
  alias Data.Room
  alias Data.RoomItem
  alias Data.User
  alias Data.Zone

  def base_save() do
    %Data.Save{
      room_id: 1,
      level: 1,
      experience_points: 0,
      item_ids: [],
      stats: %{
        health: 50,
        max_health: 50,
        skill_points: 50,
        max_skill_points: 50,
        strength: 10,
        intelligence: 10,
        dexterity: 10,
      },
      wearing: %{},
      wielding: %{},
    }
  end

  defp user_attributes(attributes) do
    Map.merge(%{
      save: base_save(),
      class_id: create_class().id,
    }, attributes)
  end

  def create_user(attributes) do
    %User{}
    |> User.changeset(user_attributes(attributes))
    |> Repo.insert!
  end

  def create_config(name, value) do
    %Config{}
    |> Config.changeset(%{name: name |> to_string, value: value})
    |> Repo.insert!
  end

  def create_room(attributes) do
    %Room{}
    |> Room.changeset(room_attributes(attributes))
    |> Repo.insert!
  end

  defp room_attributes(attributes) do
    Map.merge(%{
      name: "Hallway",
      description: "A long empty hallway",
    }, attributes)
  end

  def create_item(attributes) do
    %Item{}
    |> Item.changeset(item_attributes(attributes))
    |> Repo.insert!
  end

  defp item_attributes(attributes) do
    Map.merge(%{
      name: "Short Sword",
      description: "A slender sword",
      type: "weapon",
      stats: %{},
      effects: [],
    }, attributes)
  end

  def create_room_item(room, item, attributes) do
    %RoomItem{}
    |> RoomItem.changeset(Map.merge(attributes, %{room_id: room.id, item_id: item.id}))
    |> Repo.insert
  end

  def create_zone(attributes) do
    %Zone{}
    |> Zone.changeset(room_attributes(attributes))
    |> Repo.insert!
  end

  def class_attributes(attributes) do
    Map.merge(%{
      name: "Fighter",
      description: "A fighter",
      points_name: "Skill Points",
      points_abbreviation: "SP",
      regen_health: 1,
      regen_skill_points: 1,
      starting_stats: %{
        health: 25,
        max_health: 25,
        strength: 10,
        intelligence: 10,
        dexterity: 10,
        skill_points: 10,
        max_skill_points: 10,
      },
    }, attributes)
  end

  def create_class(attributes \\ %{}) do
    %Class{}
    |> Class.changeset(class_attributes(attributes))
    |> Repo.insert!
  end
end
