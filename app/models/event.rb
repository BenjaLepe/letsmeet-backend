class Event < ApplicationRecord
  # Associations
  enum :state, %i[draft published archived]
  belongs_to :producer
  belongs_to :author, class_name: 'User'
  has_many :tickets
  has_many :ticket_types, class_name: 'EventTicket'
  # Validations
  validate :author_id_not_changed
  validate :producer_id_not_changed
  # Scopes
  scope :by_state, ->(state) { where(state: state) }
  scope :search, ->(query) { where('title ILIKE ?', "%#{query}%") }
  scope :by_producer, ->(producer_id) { where(producer_id: producer_id) }
  scope :by_author, ->(author_id) { where(author_id: author_id) }
  scope :by_category, ->(category_id) { joins(:categories).where(categories: { id: category_id }) }
  scope :by_date, ->(date) { where('start_time >= ? AND end_time <= ?', date.beginning_of_day, date.end_of_day) }
  scope :by_date_range, lambda { |start_date, end_date|
                          where('start_time >= ? AND end_time <= ?', start_date.beginning_of_day, end_date.end_of_day)
                        }
  scope :order_by_start_date, ->(date = -1) { order(start_time: (date == -1 ? :desc : :asc)) }

  private

  def author_id_not_changed
    return unless author_id_changed? && persisted?

    errors.add(:author_id, 'Change of author not allowed!')
  end

  def producer_id_not_changed
    return unless producer_id_changed? && persisted?

    errors.add(:producer_id, 'Change of producer not allowed!')
  end
end
