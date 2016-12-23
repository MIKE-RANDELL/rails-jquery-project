module ItemsHelper
  def includes_pallet(item)
    if item.with_pallet
      'Yes'
    else
      'No'
    end
  end
end
