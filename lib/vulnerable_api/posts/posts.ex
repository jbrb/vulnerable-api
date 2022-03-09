defmodule VulnerableApi.Posts do
  import Ecto.Query

  alias VulnerableApi.Posts.Post
  alias VulnerableApi.Repo

  def create_post(attrs) do
    %Post{user_id: attrs.user_id}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def list_posts(preload \\ []) do
    Post
    |> join(:left, [p], c in assoc(p, :comments))
    |> join(:left, [_p, c], u in assoc(c, :user))
    |> join(:left, [p], uu in assoc(p, :user))
    |> join(:left, [_, _, u], cc in assoc(u, :credits))
    |> preload(^preload)
    |> Repo.all()
  end

  def list_user_posts(user_id, preload \\ []) do
    Post
    |> where(user_id: ^user_id)
    |> preload(^preload)
    |> Repo.all()
  end

  def get_post(id), do: Repo.get(Post, id)

  def update_post(post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(post), do: Repo.delete(post)

  def data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end
end
