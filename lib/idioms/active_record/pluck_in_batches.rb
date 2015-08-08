module PluckInBatches
  def pluck_in_batches(*args, &block)
    options = args.extract_options!
    batch_size = options.fetch(:batch_size, 500)
    batches = (count / batch_size.to_f).ceil
    query = reorder(:id)
  
    batches.times do |i|
      query.limit(batch_size).offset(i * batch_size).pluck(*args).each(&block)
    end
    nil
  end
end

ActiveRecord::Relation.send :include, PluckInBatches
