tab_nom = ['andry', 'bema', 'fetra', 'rina']
@tab_user
@tab_status

tab_id = [3, 2, 4, 6]
tab = Hash.new
i = 0
@tab_status.each do |id|
    tab[id] = tab_user[i]
    i+=1
end

p h

# Je veux afficher id 3 = andry