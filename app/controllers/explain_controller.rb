class ExplainController < ApplicationController

  def top
    # ダンジョン取得
    @dungeons = Dungeon.all.GetUriDungeon(params[:dungeon])
    if @dungeons.count != 1
        redirect_to "/"
        return
    end
    @dungeons.each do |dung|
      @dungeon = dung
    end
    # 指定したダンジョンの解説取得
    @explains = Explanation.all.GetExplanation(@dungeon.id).where(release: true)
  end

  def explain
    # ダンジョン取得
    @dungeons = Dungeon.all.GetUriDungeon(params[:dungeon])
    if @dungeons.count != 1
        redirect_to "/"
        return
    end
    @dungeons.each do |dung|
      @dungeon = dung
    end

    # 解説取得
    @explains = Explanation.all.GetExplanation(@dungeon.id)
    @explain = @explains.find_by(id: params[:id])
    if @explain == nil
      redirect_to "/"
        return
    end
    render layout: "reveal"
  end

  def edit
    # ダンジョン取得
    @dungeons = Dungeon.all.GetUriDungeon(params[:dungeon])
    unless @dungeons.count == 1 && (current_user.try(:admin?) || current_user.try(:super_admin?))
        redirect_to "/"
        return
    end
    @dungeons.each do |dung|
      @dungeon = dung
    end
    # 解説取得
    @explains = Explanation.all.GetExplanation(@dungeon.id)
    @explain = @explains.find_by(id: params[:id])
    if @explain == nil
      redirect_to "/"
        return
    end
  end

  def preview
    
  end
end