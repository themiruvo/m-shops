function _L(key, ...)
    local locale = Locales[Config.Locale] or Locales['en']
    local str = locale[key] or key
    if select("#", ...) > 0 then
        return string.format(str, ...)
    end
    return str
end
