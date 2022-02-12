defmodule VulnerableApiWeb.GraphQL.Resolvers.PostResolver do
  alias VulnerableApi.Posts

  def list_posts(%{user_id: user_id}, _) do
    {:ok, Posts.list_user_posts(user_id, [comments: :user])}
  end

  def create_post(args, _) do
    Posts.create_post(args)
  end

  def update_post(%{post_id: post_id} = args, _) do
    case Posts.get_post(post_id) do
      %{id: _} = post ->
        Posts.update_post(post, args)

      _ ->
        {:error, %{message: "Post not found."}}
    end
  end

  def delete_post(%{post_id: post_id}, _) do
    case Posts.delete_post(post_id) do
      %{id: _} = post ->
        Posts.delete_post(post)

      _ ->
        {:error, %{message: "Post not found."}}
    end
  end
end
