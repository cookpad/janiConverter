
class StorageSettings < Settingslogic
  source "#{Rails.root}/config/strages.yml"
  namespace Rails.env
end
