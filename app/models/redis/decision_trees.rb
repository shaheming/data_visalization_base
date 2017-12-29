require 'csv'
class Redis::DecisionTrees
  REDIS_TIME_OUT = 4
  STATE = {
      :success => "Success",
      :training => "Training",
      :failed => "Failed"
  }.freeze

  def self.find(id)
    keys = $redis.keys.grep(/#{id}.*/).map {|item| item.gsub("#{@id}_", "")}
    Rails.logger.info("Select Redis::DecisionTrees WHERE id  = #{id}")
    if keys.blank?
      return {}
    else
      return Redis::DecisionTrees.new(id)
    end
  end

  def schedule_auto_save_job
    DecisionTreeExpireWorker.cancel!(self.auto_save_jid)
    self.auto_save_jid = DecisionTreeExpireWorker.perform_in((REDIS_TIME_OUT.hour - 5.minutes), id)
    Rails.logger.info("New job_id #{self.auto_save_jid}")
  end


  def method_missing(method_name, *args, &blk)
    match = method_name.to_s.match(/(.*?)([=]?)$/)
    case match[2]
      when "="
        $redis.set("#{@id}_#{match[1]}", {:data => args[0]}.to_json)
        $redis.expire("#{@id}_#{match[1]}", REDIS_TIME_OUT.hour.to_i)
      else
        (JSON.parse($redis.get("#{@id}_#{match[1]}")) rescue {})["data"]
    end
  end

  def error_message
    error_message = $redis.get("#{@id}_error_message")
    $redis.del("#{@id}_error_message")
    error_message
  end


  def save_data(data)
    self.validate_result = (data["data"]["validate_result"].to_f * 100).round(3).to_s + "%"
    self.tree_structure = data["data"]["hash_form_tree_struct"]
    self.node_data = data["data"]["node_data"]
    self.divide_leaf_by_level(data["data"])

    # self.feat_names ||= data["data"]["feat_names"]
    time_consumption = data["data"]["time_consumption"].to_f
    self.time_consumption = Time.at(time_consumption).utc.strftime("%H:%M:%S")

  end

  def update(data)
    self.save_data(data)
  end

  def update_attributes(attributes)
    return if attributes.blank?
    new_attributes = attributes.stringify_keys
    new_attributes.each do |k, v|
      self.send("#{k}=", v)
    end
  end

  def delete
    if self.auto_save_jid
      DecisionTreeExpireWorker.cancel!(self.auto_save_jid)
    end
    attr_keys = $redis.keys.grep(/#{@id}.*/)
    attr_keys.each {|key| $redis.del(key)}
  end

  def attributes
    $redis.keys.grep(/#{@id}.*/).map {|item| item.gsub("#{@id}_", "")}
  end

  def initialize(id, data = nil)
    @id = id.to_i
    self.id = id.to_i
    if data.present?
      self.save_data(data)
    end
  end

  def update_key_expire_time
    Rails.logger.info("Reset key expire time of clt_tree: #{@id}")
    keys = $redis.keys.grep(/#{@id}.*/)
    keys.each {|key|
      $redis.expire(key, REDIS_TIME_OUT.hour.to_i)
    }
  end

end