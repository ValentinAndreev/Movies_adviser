# frozen_string_literal: true

# Result message for finded movies
class FindMoviesMessage
  def self.message(params)
    return params[:genres].downcase if params.except(:genres) == ''
    message = params.except(:page).values.delete_if(&:empty?).join(', ').downcase.chomp(', 0')
    message.sub!('1', 'reversed') if params[:order] == '1'
    message == '0' ? 'all movies' : message
  end
end
