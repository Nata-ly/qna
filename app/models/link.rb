class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true
  validates :url, url: true

  GIST_HOST = 'gist.github.com'

  def gist?
    URI.parse(self.url).host == GIST_HOST
  end
end
