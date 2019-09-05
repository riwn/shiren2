class TaController < ApplicationController

  def saihateta
    @dunnum = 0
    @dungeon = Constants::DUNGEON_NAME[@dunnum]
    @duncolor = Constants::DUNGEON_COLOR[@dunnum]
  end

  def wellta
    @dunnum = 1
    @dungeon = Constants::DUNGEON_NAME[@dunnum]
    @duncolor = Constants::DUNGEON_COLOR[@dunnum]
    render 'saihateta'
  end

  def onigashimata
    @dunnum = 2
    @dungeon = Constants::DUNGEON_NAME[@dunnum]
    @duncolor = Constants::DUNGEON_COLOR[@dunnum]
    render 'saihateta'
  end

  def storyta
    @dunnum = 3
    @dungeon = Constants::DUNGEON_NAME[@dunnum]
    @duncolor = Constants::DUNGEON_COLOR[@dunnum]
    render 'saihateta'
  end

  def shrineta
    @dunnum = 4
    @dungeon = Constants::DUNGEON_NAME[@dunnum]
    @duncolor = Constants::DUNGEON_COLOR[@dunnum]
    render 'saihateta'
  end
end
