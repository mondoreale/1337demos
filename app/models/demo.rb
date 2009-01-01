class Demo < ActiveRecord::Base
  @@video_width = 384
  @@video_height = 288
  cattr_reader :video_width, :video_height

  include FlexRating

  has_and_belongs_to_many :players
  belongs_to :map
  belongs_to :demofile, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy, :order => 'created_at ASC'

  validates_presence_of :map_id
  validates_presence_of :demofile_id
  validates_presence_of :title, :on => :update, :if => Proc.new{|demo| demo.gamemode == 'freestyle'}
  validates_associated :players, :on => :update

  def validate
    #logger.info "status: #{self.status}"
    errors.add(:status, 'can not be "rendered" without an existing video file') if self.status == :rendered && !File.exists?(self.video_filename)
    #logger.info "error cnt: #{errors.count}"
  end

  def validate_on_update
    errors.add(:data_correct, "can't be empty") if self.data_correct.nil?
  end



  named_scope :race, :conditions => 'demos.data_correct AND demos.gamemode = "race"'
  named_scope :freestyle, :conditions => 'data_correct AND gamemode = "freestyle"'



  def <=>(o)
    return 0 if o.class != Demo || self.gamemode != o.gamemode

    case(self.gamemode)
    when "race"
      self.time <=> o.time
    else
      0
    end
  end



  def position
    return @position unless @position.nil?
    return nil if self.gamemode != 'race'

    pos = 0
    demos = self.map.demos.race
    return 1 if demos.length == 1

    demos = demos.sort.collect {|demo| demo unless demo.time == self.time && demo != self}.compact

    # just consider best time of each player
    known_players = []
    demos = demos.inject([]) do |list, demo|
      if !known_players.include?(demo.players.first)
        known_players << demo.players.first
        list << demo
      end
      list
    end

    res = demos.index(self)
    @position = res.nil? ? nil : 1 + res
  end

  def rerender
    self.status = :uploaded
    save!
  end

  def video_exists?
    self.status == :rendered && File.exists?(self.video_filename)
  end

  def video_filename
    "#{SYS_VIDEOS}#{self.id}.mp4"
  end

  def video_url
    return "#{WEB_VIDEOS}#{self.id}.mp4" if self.video_exists?
  end

  def video_file
    self.id.to_s + ".mp4"
  end
end
