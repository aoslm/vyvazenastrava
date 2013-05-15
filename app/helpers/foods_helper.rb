#encoding: utf-8
module FoodsHelper

  def get_my_menu
    @menus = current_user.menus.select { |menu| menu.users.first == current_user }
  end

  def do_filter
    i = 0
    @params.each do |key, value|
      if value.sub(",", ".").to_f > 0
        if i == 0
          @elements = ElementsType.find_by_name(key).elements.includes(:composition).select { |e| e
          .amount>
              value
              .to_f }

          @elements.each do |e|
            @foods.add(e.composition.food)
            #break if @foods.count() > 150
          end
          i += 1
        elsif i > 5
          break
        else
          i += 1
          @foods = @foods.select { |food| accept(food, value, key) }
        end
      end
    end
  end


  def get_max
    @array = []
    ElementsType.includes(:elements).all.each do |element|
      max = 0
      element.elements.each { |a|
        if (a.amount > max) then
          max = a.amount and @prvok = a
        end
      }
      @array.append(@prvok)
    end
  end

  def add_food_to_menu
    menu = Menu.find(params[:menu_id])
    food = Food.find(params[:food_id])
    amount = params[:amount]
    menusfood = MenusFood.where(:menu_id => menu.id, :food_id => food.id)

    if (menu.users.first == current_user)
      if menusfood.empty?
        MenusFood.create(menu: menu, food: food, amount: amount)
        food.update_attribute("rank", food.rank + 1)
      else
        menusfood.first.amount = amount
        menusfood.first.save
      end
    else
      flash[:error] = "Nemôžeš pridať jedlo do menu iného používateľa."
      redirect_to foods_path
    end
  end

  def getFood
    @food = Food.find(params[:id])
  end

  def update_types
    category = Category.find(params[:category_id])
    @types = category.types.map { |t| [t.description, t.id] } #.insert(0,"Vyber typ jedla")
  end


  def get
    @user = User.find_by_username :admin
    #@type = Type.create(:name => "prílohy (zemiaky, ryža, knedľa)")
    #@category = Category.create(:name => "Prílohy,omáčky, šaláty")
    #@category = Category.find_by_name("Polievky") ;
    #TypesCategory.create(:type => @type, :category => @category);


    for i in params[:from].to_i..params[:to].to_i do
        html = Curl.get("http://www.pbd-online.sk/sk/menu/welcome/detail/?id=#{i}").body_str
        doc = Nokogiri.HTML(html, nil, 'utf-8')

        @podskupina = ""
        @komodita=""

        doc.search('script').each do |nazov|
          nazov = nazov.to_s
          nazov = nazov.slice!(/h1.*h1/)
          @slovakname = nazov[3..nazov.size-5]
        end
        if (Food.find_all_by_slovakname(@slovakname).empty?)
           puts "UKLADAM" + @slovakname
          @food = Food.new(:user => @user, :slovakname => @slovakname, :category => Category.find_by_name("prilohy"))
        @composition = Composition.create(:food => @food, :user => @user)

        doc.search('.datatable tr').each do |tr|
          @a = tr.search('td')
          #puts @a.first.text.lstrip.chomp

          if (@a.first.text.lstrip.chomp === "Základná skupina")
            @skupina = @a.last.text.lstrip.chomp
            # puts "skupina" + @skupina
          else
            if (@a.first.text.lstrip.chomp === "Podskupina")
              @podskupina = @a.last.text.lstrip.chomp
              # puts "podskupina" + @podskupina

            else
              if (@a.first.text.lstrip.chomp === "Komodita")
                @komodita = @a.last.text.lstrip.chomp
                # puts "komodita" + @komodita

              else
                if (@a.first.text.lstrip.chomp === "Subkomodita")
                  @subkomodita = @a.last.text.lstrip.chomp
                  #puts "subkomodita" + @subkomodita

                else

                  if (@a.first.text.lstrip.chomp === "Anglický názov potraviny")
                    @food.englishname = @a.last.text.lstrip.chomp
                  else
                    if (@podskupina != "")
                      getCategory();
                    else
                      if @a[2] != nil && @a[2].text.lstrip.chomp != ''
                        #puts @a[2].text.lstrip.chomp
                        case ("#{@a.first.text.lstrip.chomp}")
                          when "VODA CELKOVÁ" then
                            saveElement("Voda")
                          when "SÚČINITEĽ JEDLÉHO PODIELU" then
                            saveElement('Súčiniteľ jedlého podielu')
                          when "SUŠINA CELKOVÁ" then
                            saveElement("Sušina")
                          when "BIELKOVINY CELKOVÉ (HR. PROTEÍN)" then
                            saveElement("Bielkoviny")
                          when "LIPIDY (TUKY) CELKOVÉ" then
                            saveElement("Tuky")
                          when "KYS. PALMITOVÁ   16:0" then
                            saveElement("Kyselina palmitová")
                          when "KYS. LINOLOVÁ   18:2n-6 **" then
                            saveElement("Kyselina linolová")
                          when "KYS. LINOLÉNOVÁ   18:3 **" then
                            saveElement("Kyselina linolénová")
                          when "MASTNÉ KYSELINY NASÝTENÉ CELKOVÉ" then
                            saveElement("Mastné kyseliny nasýtené")
                          when "MASTNÉ KYSELINY MONONENASÝTENÉ CELKOVÉ" then
                            saveElement("Mastné kyseliny mononenasýtené")
                          when "MASTNÉ KYSELINY POLYNENASÝTENÉ CELKOVÉ" then
                            saveElement("Mastné kyseliny polynenasýtené")
                          when "trans-MASTNÉ KYSELINY CELKOVÉ" then
                            saveElement("Trans-mastné kyseliny")
                          when "CHOLESTEROL" then
                            saveElement("Cholesterol")
                          when "SACHARIDY CELKOVÉ" then
                            saveElement("Sacharidy")
                          when "SACHARÓZA" then
                            saveElement("Sacharóza")
                          when "ŠKROB" then
                            saveElement("Škrob")
                          when "POTRAVINOVÁ VLÁKNINA CELKOVÁ" then
                            saveElement("Vláknina")
                          when "POTRAVINOVÁ VLÁKNINA CELKOVÁ VYPOČÍTANÁ" then
                            saveElement("Vláknina vypočítaná")
                          when "ALKOHOLICKÉ CUKRY (POLYOLY) CELKOVÉ" then
                            saveElement("Alkoholické cukry")
                          when "ORGANICKÉ KYSELINY CELKOVÉ" then
                            saveElement("Organické kyseliny")
                          when "MINERÁLNE LÁTKY (POPOL)" then
                            saveElement("Minerálne látky")
                          when "SODÍK   **  Na" then
                            saveElement("Sodík")
                          when "HORČÍK   **  Mg" then
                            saveElement("Horčík")
                          when "FOSFOR   **  P" then
                            saveElement("Fosfor")
                          when "SÍRA   **  S" then
                            saveElement("Síra")
                          when "DRASLÍK   **  K" then
                            saveElement("Draslík")
                          when "VÁPNIK   **  Ca" then
                            saveElement("Vápnik")
                          when "ŽELEZO   **  Fe" then
                            saveElement("Železo")
                          when "MEĎ   **  Cu" then
                            saveElement("Meď")
                          when "ZINOK   **  Zn" then
                            saveElement("Zinok")
                          when "SELÉN   **  Se" then
                            saveElement("Selén")
                          when "JÓD   **  I" then
                            saveElement("Jód")
                          when "CHLORID SODNÝ (KUCHYNSKÁ SOĽ)" then
                            saveElement("Kuchynská soľ")
                          when "VITAMÍN A 1 (RETINOL)" then
                            saveElement("Vitamín A1")
                          when "KAROTÉN" then
                            saveElement("Karotén")
                          when "RETINOL EKVIVALENT (RE) (vypočítaný), VITAMÍN A" then
                            saveElement("Vitamín A vypočítaný")
                          when "VITAMÍN D (KALCIFEROL)" then
                            saveElement("Vitamín D")
                          when "VITAMÍN E (TOKOFEROLY)" then
                            saveElement("Vitamín E")
                          when "VITAMÍN B 1 (TIAMÍN)" then
                            saveElement("Vitamín B1")
                          when "VITAMÍN B 2 (RIBOFLAVÍN)" then
                            saveElement("Vitamín B2")
                          when "VITAMÍN PP (KYS. NIKOTÍNOVÁ, NIACÍN, NIKOTÍNAMID, NIACÍNAMID)" then
                            saveElement("Kyselina nikotínová")
                          when "VITAMÍN B 5 (KYS. PANTOTÉNOVÁ)" then
                            saveElement("Vitamín B5")
                          when "VITAMÍN PP (NIACÍN EKVIVALENT)"
                            saveElement("Súčiniteľ jedlého podielu")
                          when "SUŠINA CELKOVÁ" then
                            saveElement("Sušina")
                          when "BIELKOVINY CELKOVÉ (HR. PROTEÍN)" then
                            saveElement("Bielkoviny")
                          when "LIPIDY (TUKY) CELKOVÉ" then
                            saveElement("Niacín")
                          when "FOLÁT CELKOVÝ" then
                            saveElement("Folát")
                          when "VITAMÍN B 6 (PYRIDOXÍNY)" then
                            saveElement("Vitamín B6")
                          when "VITAMÍN B 12 (KOBALAMÍNY)" then
                            saveElement("Vitamín B12")
                          when "VITAMÍN   C" then
                            saveElement("Vitamín C")
                          when "ETYLALKOHOL" then
                            saveElement("Etylalkohol")
                          when "ENERGETICKÁ HODNOTA EÚ" then
                            # puts "------------------------ #{@a[2].text.lstrip.chomp}"
                            if (@a[2].text.lstrip.chomp.include? "kJ")
                              saveElement("Energetická hodnota kJ")
                            else
                              saveElement("Energetická hodnota kcal")
                            end
                          when "ENERGETICKÁ HODNOTA EÚ Z BIELKOVÍN" then
                            saveElement("Energetická hodnota bielkovín")
                          when "ENERGETICKÁ HODNOTA EÚ LIPIDOV (TUKOV)" then
                            saveElement("Energetická hodnota tukov")
                          when "ENERGETICKÁ HODNOTA EÚ ZO SACHARIDOV" then
                            saveElement("Energetická hodnota sacharidov")
                          when "ENERGETICKÁ HODNOTA EÚ Z ALKOHOLU" then
                            saveElement("Energetická hodnota alkoholu")
                        end
                      end
                    end
                  end
                end
              end
            end
          end
          @food.save
        end
      else
        puts "Je tam neico" + i.to_s
      end


    end
  end

  def saveElement(name)
    Element.create(:amount => @a[2].text.lstrip.chomp,
                   :composition => @composition,
                   :elements_type => ElementsType.find_by_name(name));
  end


  def getCategory()
    if (@podskupina === "PREDKRMY" && @komodita === "slané")
      saveCategory("studena", "natierky")
    elsif (@podskupina === "POLIEVKY" && @komodita === "mäsové")
      saveCategory("polievky", "masove")
    elsif (@podskupina === "POLIEVKY" && @komodita === "strukovinové")
      saveCategory("polievky", "strukovinove")
    elsif (@podskupina === "POLIEVKY" && @komodita === "obilninové")
      saveCategory("polievky", "obilninove")
    elsif (@podskupina === "POLIEVKY" && @komodita === "zeleninové")
      saveCategory("polievky", "zeleninove")
    elsif (@podskupina === "POLIEVKY" && @komodita === "iné")
      saveCategory("polievky", "ine")
    elsif (@podskupina === "HLAVNÉ POKRMY" && @komodita === "mäsové")
      saveCategory("hlavne", "masove")
    elsif (@podskupina === "HLAVNÉ POKRMY" && @komodita === "bezmäsité" && @subkomodita === "sladké")
      saveCategory("hlavne", "sladke")
    elsif (@podskupina === "HLAVNÉ POKRMY" && @komodita === "bezmäsité" && @subkomodita === "slané")
      saveCategory("hlavne", "cestoviny")
    elsif (@podskupina === "HLAVNÉ POKRMY" && @komodita === "polomäsité")
      saveCategory("hlavne", "zapekane")
    elsif (@podskupina === "PRÍLOHY" && @komodita === "zeleninové")
      saveCategory("prilohy", "zeleninove")
    elsif (@podskupina === "PRÍLOHY" && @komodita === "bezmäsité")
      saveCategory("prilohy", "kase")
    elsif (@podskupina === "PRÍLOHY" && @komodita === "základné")
      saveCategory("prilohy", "prilohy")
    elsif (@podskupina === "PRÍLOHY" && @komodita === "omáčky")
      saveCategory("prilohy", "omacky")
    elsif (@podskupina === "PRÍLOHY" && @komodita === "šaláty")
      saveCategory("prilohy", "zeleninove")
    elsif (@podskupina === "DEZERTY" && @komodita === "pudingy, krémy")
      saveCategory("sladke", "pudingy")
    elsif (@podskupina === "NÁPOJE" && @komodita === "teplé")
      saveCategory("napoje", "caje")
    elsif (@podskupina === "NÁPOJE" && @komodita === "chladené")
      saveCategory("napoje", "sladene")
    elsif (@podskupina === "VODY" && @komodita === "minerálne, pramenité")
      saveCategory("napoje", "vody")
    elsif (@podskupina === "DEZERTY" && @komodita === "pudingy, krémy")
      saveCategory("sladke", "pudingy")
    elsif (@podskupina === "MÄSO JATOČNÝCH ZVIERAT")
      saveCategory("zivocisne", "masove")
    elsif (@podskupina === "MLIEKO")
      saveCategory("zivocisne", "mlieko")
    elsif (@podskupina === "VAJCIA")
      saveCategory("zivocisne", "vajcia")
    elsif (@podskupina === "TUKY, OLEJNINY, ORECHY")
      saveCategory("zivocisne", "tuky")
    elsif (@podskupina === "STRUKOVINY")
      saveCategory("rastlinne", "zeleninove")
    elsif (@podskupina === "OBILNINY")
      saveCategory("rastlinne", "pecivo")
    elsif (@podskupina === "LIEHOVINY")
      saveCategory("napoje", "liehoviny")
    elsif (@podskupina === "VÍNO")
      saveCategory("napoje", "pivovino")
    elsif (@podskupina === "PIVO")
      saveCategory("napoje", "pivovino")
    elsif (@podskupina === "NEALKOHOLICKÉ NÁPOJE")
      saveCategory("napoje", "sladene")
    elsif (@podskupina === "VODY")
      saveCategory("napoje", "vody")
    elsif (@podskupina === "DROŽDIE")
      saveCategory("zivocisne", "drozdie")
    elsif (@podskupina === "KORENINY, BYLINKY")
      saveCategory("rastlinne", "koreniny")
    elsif (@podskupina === "INÉ OCHUCOVADLÁ")
      saveCategory("studena", "ochucovadla")
    elsif (@podskupina === "KAKAO, KÁVA, ČAJ")
      saveCategory("napoje", "caje")
    elsif (@podskupina === "OKOPANINY, MED")
      saveCategory("zivocisne", "med")
    elsif (@podskupina === "OVOCIE")
      saveCategory("rastlinne", "ovocie")
    elsif (@podskupina === "ZELENINA, HUBY")
      saveCategory("rastlinne", "zeleninove")
    else
      puts "CHYBA!"
      breakpoint
    end

    @podskupina = ""
    @komodita=""
    @subkomodita = ""
  end

  def saveCategory(category, type)
    @food.category = Category.find_by_name(category)
    FoodsType.create(:food => @food, :type => Type.find_by_name(type))
  end

end
