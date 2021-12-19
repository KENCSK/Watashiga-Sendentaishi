class PrefecturesController < ApplicationController
  def index
    @prefecture_ranks = Prefecture.sort_prefecture_by_charm_rank
  end
end
