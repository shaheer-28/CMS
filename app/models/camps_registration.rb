class CampsRegistration < ApplicationRecord
  belongs_to :camp
  belongs_to :user
  has_one_attached :user_image

  attr_accessor :application_completed

  def application_completed
    @completed_steps = 0
    # @application_completed = progress.each { |e|
    #   @completed_steps = @completed_steps + (1 if e.true)
    # }
    @completed_steps = @completed_steps + 1 if self.filled_screen1
    @completed_steps = @completed_steps + 1 if self.filled_screen2
    @completed_steps = @completed_steps + 1 if self.filled_screen3
    @completed_steps = @completed_steps + 1 if self.filled_screen4
    @completed_steps = @completed_steps + 1 if self.filled_screen5
    @completed_steps = @completed_steps + 1 if self.filled_screen6
    @completed_steps = @completed_steps + 1 if self.filled_screen7
    @completed_steps = @completed_steps + 1 if self.filled_screen8
    @completed_steps = @completed_steps + 1 if self.filled_screen9
    @completed_steps = @completed_steps + 1 if self.filled_screen10

    @application_completed = (@completed_steps * 100 / 10)
  end
end
