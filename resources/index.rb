actions :create, :delete
default_action :create

attribute :name, kind_of: String, name_attribute: true, required: true
attribute :type, equal_to: %w(plain distributed rt template), default: 'plain'
attribute :source, kind_of: [String, Array]
attribute :path, kind_of: String
attribute :docinfo, equal_to: %w(none extern inline)
attribute :rt_mem_limit, kind_of: String
attribute :rt_field, kind_of: [String, Array]
attribute :rt_attr_uint, kind_of: [String, Array]
attribute :rt_attr_bool, kind_of: [String, Array]
attribute :rt_attr_bigint, kind_of: [String, Array]
attribute :rt_attr_float, kind_of: [String, Array]
attribute :rt_attr_multi, kind_of: [String, Array]
attribute :rt_attr_timestamp, kind_of: [String, Array]
attribute :rt_attr_string, kind_of: [String, Array]
attribute :rt_attr_json, kind_of: [String, Array]
attribute :morphology, kind_of: [Array, String], callbacks: {
  'Attribute must be one of list!' => lambda do |morphology|
    Chef::Resource::SphinxIndex.validate_morphology(morphology)
  end
}
attribute :min_word_len, kind_of: Integer
attribute :min_prefix_len, kind_of: Integer
attribute :index_exact_words, kind_of: Integer
attribute :expand_keywords, kind_of: Integer
attribute :html_strip, kind_of: [TrueClass, FalseClass]
attribute :html_remove_elements, kind_of: Array
attribute :wordforms, kind_of: Array
attribute :stopwords, kind_of: [String, Array]
attribute :stopword_step, equal_to: [0, 1]
attribute :blend_mode, kind_of: [String, Array], callbacks: {
  'Attribute must be one of list!' => lambda do |blend_mode|
    Chef::Resource::SphinxIndex.validate_blend_mode(blend_mode)
  end
}
attribute :blend_chars, kind_of: [String, Array]
attribute :charset_table, kind_of: Array
attribute :ngram_len, equal_to: [0, 1]
attribute :ngram_chars, kind_of: Array
attribute :enable_star, kind_of: [TrueClass, FalseClass]

private

def self.validate_blend_mode(blend_mode)
  valid_values = %w(trim_none trim_head trim_tail trim_both skip_pure)
  blend_mode = [blend_mode] if blend_mode.is_a?(String)
  blend_mode.each do |mode|
    return false unless valid_values.include?(mode)
  end
  true
end

def self.validate_morphology(morphology)
  valid_values = %w(lemmatize_ru lemmatize_en lemmatize_de lemmatize_ru_all
                    lemmatize_en_all lemmatize_de_all stem_en stem_ru stem_enru stem_cz stem_ar soundex
                    metaphone rlp_chinese rlp_chinese_batched)
  morphology = [morphology] if morphology.is_a?(String)
  morphology.each do |mode|
    return false unless valid_values.include?(mode)
  end
  true
end
