defmodule VulnerableApiWeb.GraphQL.Resolvers.CommentResolver do
  alias VulnerableApi.Comments

  def create_comment(args, _) do
    Comments.create_comment(args)
  end

  def update_comment(%{comment_id: comment_id} = args, _) do
    case Comments.get_comment(comment_id) do
      %{id: _} = comment ->
        Comments.update_comment(comment, args)

      _ ->
        {:error, %{message: "Comment not found."}}
    end
  end

  def delete_comment(%{comment_id: comment_id}, _) do
    case Comments.get_comment(comment_id) do
      %{id: _} = comment ->
        Comments.delete_comment(comment)

      _ ->
        {:error, %{message: "Comment not found."}}
    end
  end
end
