defmodule VulnerableApi.Comments do
  import Ecto.Query, warn: false
  alias VulnerableApi.Comments.Comment
  alias VulnerableApi.Repo

  def get_comment(comment_id) do
    Repo.get_by(Comment, comment_id: comment_id)
  end

  def create_comment(attrs) do
    %Comment{user_id: attrs.user_id, post_id: attrs.post_id}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  def list_post_comments(post_id) do
    Comment
    |> where(post_id: ^post_id)
    |> Repo.all()
  end

  def update_comment(comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  def delete_comment(comment), do: Repo.delete(comment)

  def data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end
end
