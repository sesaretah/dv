module UnicodeFixer
  extend self
  def fix(str)
    # الف
    str.gsub!('ﺎ', 'ا')
    str.gsub!('ﺍ', 'ا')
    str.gsub!('ﺈ', 'ا')
    str.gsub!('ﺇ', 'ا')
    str.gsub!('ﺄ', 'ا')
    str.gsub!('ﺃ', 'ا')
    str.gsub!('ﺂ', 'ا')
    str.gsub!('ﺁ', 'ا')
    # ب
    str.gsub!('ﺒ', 'ب')
    str.gsub!('ﺑ', 'ب')
    str.gsub!('ﺐ', 'ب')
    str.gsub!('ﺏ', 'ب')
    # ه
    str.gsub!('ﺔ', 'ه')
    str.gsub!('ﺓ', 'ه')
    # ت
    str.gsub!('ﺘ', 'ت')
    str.gsub!('ﺗ', 'ت')
    str.gsub!('ﺖ', 'ت')
    str.gsub!('ﺕ', 'ت')
    # ث
    str.gsub!('ﺜ', 'ث')
    str.gsub!('ﺛ', 'ث')
    str.gsub!('ﺚ', 'ث')
    str.gsub!('ﺙ', 'ث')
    #  ج
    str.gsub!('ﺠ', 'ج')
    str.gsub!('ﺟ', 'ج')
    str.gsub!('ﺞ', 'ج')
    str.gsub!('ﺝ', 'ج')
    # ح
    str.gsub!('ﺤ', 'ح')
    str.gsub!('ﺣ', 'ح')
    str.gsub!('ﺢ', 'ح')
    str.gsub!('ﺡ', 'ح')

    str.gsub!('ﺨ', 'خ')
    str.gsub!('ﺧ', 'خ')
    str.gsub!('ﺦ', 'خ')
    str.gsub!('ﺥ', 'خ')

    str.gsub!('ﺪ', 'د')
    str.gsub!('ﺩ', 'د')

    str.gsub!('ﺬ', 'ذ')
    str.gsub!('ﺫ', 'ذ')

    str.gsub!('ﺮ', 'ر')
    str.gsub!('ﺭ', 'ر')

    str.gsub!('ﺰ', 'ز')
    str.gsub!('ﺯ', 'ز')

    str.gsub!('ﺴ', 'س')
    str.gsub!('ﺳ', 'س')
    str.gsub!('ﺲ', 'س')
    str.gsub!('ﺱ', 'س')

    str.gsub!('ﺸ', 'ش')
    str.gsub!('ﺷ', 'ش')
    str.gsub!('ﺶ', 'ش')
    str.gsub!('ﺵ', 'ش')

    str.gsub!('ﺼ', 'ص')
    str.gsub!('ﺻ', 'ص')
    str.gsub!('ﺺ', 'ص')
    str.gsub!('ﺹ', 'ص')

    str.gsub!('ﻀ', 'ض')
    str.gsub!('ﺿ', 'ض')
    str.gsub!('ﺾ', 'ض')
    str.gsub!('ﺽ', 'ض')

    str.gsub!('ﻄ', 'ط')
    str.gsub!('ﻃ', 'ط')
    str.gsub!('ﻂ', 'ط')
    str.gsub!('ﻁ', 'ط')

    str.gsub!('ﻈ', 'ظ')
    str.gsub!('ﻇ', 'ظ')
    str.gsub!('ﻆ', 'ظ')
    str.gsub!('ﻅ', 'ظ')

    str.gsub!('ﻌ', 'ع')
    str.gsub!('ﻋ', 'ع')
    str.gsub!('ﻊ', 'ع')
    str.gsub!('ﻉ', 'ع')

    str.gsub!('ﻐ', 'غ')
    str.gsub!('ﻏ', 'غ')
    str.gsub!('ﻎ', 'غ')
    str.gsub!('ﻍ', 'غ')

    str.gsub!('ﻔ', 'ف')
    str.gsub!('ﻓ', 'ف')
    str.gsub!('ﻒ', 'ف')
    str.gsub!('ﻑ', 'ف')

    str.gsub!('ﻘ', 'ق')
    str.gsub!('ﻗ', 'ق')
    str.gsub!('ﻖ', 'ق')
    str.gsub!('ﻕ', 'ق')

    str.gsub!('ﻜ', 'ک')
    str.gsub!('ﻛ', 'ک')
    str.gsub!('ﻚ', 'ک')
    str.gsub!('ﻙ', 'ک')
    str.gsub!('ك', 'ک')

    str.gsub!('ﻠ', 'ل')
    str.gsub!('ﻟ', 'ل')
    str.gsub!('ﻞ', 'ل')
    str.gsub!('ﻝ', 'ل')

    str.gsub!('ﻤ', 'م')
    str.gsub!('ﻣ', 'م')
    str.gsub!('ﻢ', 'م')
    str.gsub!('ﻡ', 'م')

    str.gsub!('ﻨ', 'ن')
    str.gsub!('ﻧ', 'ن')
    str.gsub!('ﻦ', 'ن')
    str.gsub!('ﻥ', 'ن')

    str.gsub!('ﻬ', 'ه')
    str.gsub!('ﻫ', 'ه')
    str.gsub!('ﻪ', 'ه')
    str.gsub!('ﻩ', 'ه')

    str.gsub!('ﻮ', 'و')
    str.gsub!('ﻭ', 'و')
    str.gsub!('ﺅ', 'و')
    str.gsub!('ﺆ', 'و')

    str.gsub!('ﻴ', 'ی')
    str.gsub!('ﻳ', 'ی')
    str.gsub!('ﻲ', 'ی')
    str.gsub!('ي', 'ی')
    str.gsub!('ﻱ', 'ی')
    str.gsub!('ﻰ', 'ی')
    str.gsub!('ﻯ', 'ی')
    str.gsub!('ی', 'ی')
    str.gsub!('ی', 'ی')
    str.gsub!('ﯿ', 'ی')
    str.gsub!('ي', 'ی')

    str.gsub!('ﻼ', 'لا')
    str.gsub!('ﻻ', 'لا')
    str.gsub!('ﻺ', 'لا')
    str.gsub!('ﻹ', 'لا')
    str.gsub!('ﻸ', 'لا')
    str.gsub!('ﻷ', 'لا')
    str.gsub!('ﻶ', 'لا')
    str.gsub!('ﻵ', 'لا')

    str.gsub!('ﮕ', 'گ')

    str.gsub!('ﺌ', 'ئ')
    str.gsub!('ﺋ', 'ئ')
    str.gsub!('ﺊ', 'ئ')
    str.gsub!('ﺉ', 'ئ')

    str.gsub!('۱', '1')
    str.gsub!('۲', '2')
    str.gsub!('۳', '3')
    str.gsub!('۴', '4')
    str.gsub!('۵', '5')
    str.gsub!('۶', '6')
    str.gsub!('۷', '7')
    str.gsub!('۸', '8')
    str.gsub!('۹', '9')
    str.gsub!('۰', '0')

    return str
  rescue
    str
  end
end
