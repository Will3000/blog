require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations" do
    it "requires a title" do
      post = Post.new
      post.valid?
      expect(post.errors).to have_key(:title)
    end

    it "requires title length minimum 7" do
      post = Post.create(title: "abc", body: "231")
      expect(post.errors).to have_key(:title)
    end

    it "requires a unique title" do
      Post.create(title: "abc", body: "1234")
      post = Post.new(title: "abc")
      post.valid?
      expect(post.errors).to have_key(:title)
    end

    it "requires a body" do
      post = Post.new
      post.valid?
      expect(post.errors).to have_key(:body)
    end
  end
  
  describe ".body_snippet" do
    it "post's body has 100 more characters" do
      post = Post.create(title: "abc", body: "0" * 200)
      expect(post.body_snippet.length).to eq(103)
    end
  end
end
