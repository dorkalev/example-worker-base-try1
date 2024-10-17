class Object
  def present?
    !blank?
  end
  def blank?
    respond_to?(:empty?) ? !!empty? : !self
  end
end

class String
  def present?
    self != ''
  end
  def blank?
    self == ''
  end
end

class Hash
  def symbolize_keys
    transform_keys{ |key| key.to_sym rescue key }
  end
  def stringify_keys
    transform_keys{ |key| key.to_s }
  end
  def transform_keys
    result = {}
    each_key do |key|
      result[yield(key)] = self[key]
    end
    result
  end
  def deep_stringify_keys
    deep_transform_keys{ |key| key.to_s }
  end
  def deep_transform_keys(&block)
    result = {}
    each do |key, value|
      result[yield(key)] = value.is_a?(Hash) ? value.deep_transform_keys(&block) : value
    end
    result
  end
end
