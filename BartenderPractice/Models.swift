import Foundation

// MARK: - Base spirit category

enum Base: String, CaseIterable, Codable, Identifiable {
    case whiskey = "위스키"
    case brandy = "브랜디"
    case vodka = "보드카"
    case gin = "진"
    case rum = "럼"
    case tequila = "데킬라"
    case liqueur = "리큐르"
    case wine = "와인"
    case korean = "전통주"
    case nonAlcoholic = "무알코올"

    var id: String { rawValue }
}

// MARK: - Glassware

enum Glass: String, CaseIterable, Codable, Identifiable {
    case cocktail = "Cocktail Glass"
    case oldFashioned = "Old Fashioned Glass"
    case highball = "Highball Glass"
    case collins = "Collins Glass"
    case footedPilsner = "Footed Pilsner Glass"
    case sour = "Sour Glass"
    case liqueur = "Stemmed Liqueur Glass"
    case sherry = "Sherry Glass"
    case saucerChampagne = "Champagne Glass (Saucer)"
    case fluteChampagne = "Champagne Glass (Flute)"
    case whiteWine = "White Wine Glass"

    var id: String { rawValue }

    var koreanName: String {
        switch self {
        case .cocktail: return "칵테일 글라스 (마티니)"
        case .oldFashioned: return "올드 패션드 글라스"
        case .highball: return "하이볼 글라스"
        case .collins: return "콜린스 글라스"
        case .footedPilsner: return "푸티드 필스너 글라스"
        case .sour: return "사워 글라스"
        case .liqueur: return "스템드 리큐르 글라스"
        case .sherry: return "셰리 글라스 (2oz)"
        case .saucerChampagne: return "샴페인 글라스 (소서)"
        case .fluteChampagne: return "샴페인 글라스 (플루트)"
        case .whiteWine: return "화이트 와인 글라스"
        }
    }
}

// MARK: - Mixing method

enum Method: String, CaseIterable, Codable, Identifiable {
    case build = "Build"
    case stir = "Stir"
    case shake = "Shake"
    case float = "Float"
    case blend = "Blend"
    case shakeBuild = "Shake / Build"
    case buildFloat = "Build / Float"

    var id: String { rawValue }

    var koreanName: String {
        switch self {
        case .build: return "빌드 (직접 넣기)"
        case .stir: return "스터 (휘젓기)"
        case .shake: return "셰이크 (흔들기)"
        case .float: return "플로트 (띄우기)"
        case .blend: return "블렌드 (갈기)"
        case .shakeBuild: return "셰이크 + 빌드"
        case .buildFloat: return "빌드 + 플로트"
        }
    }

    var detail: String {
        switch self {
        case .build: return "글라스에 얼음을 넣고 재료를 직접 부어 바 스푼으로 가볍게 젓는다."
        case .stir: return "믹싱 글라스에 얼음과 재료를 넣고 바 스푼으로 저은 뒤 스트레이너로 걸러 따른다."
        case .shake: return "셰이커에 얼음과 재료를 넣고 흔든 뒤 스트레이너로 걸러 따른다."
        case .float: return "비중 차이를 이용해 바 스푼 뒷면으로 재료를 층층이 띄운다."
        case .blend: return "블렌더에 크러시드 아이스와 재료를 넣고 갈아 따른다."
        case .shakeBuild: return "기주·주스·설탕은 셰이크, 탄산수는 글라스에서 빌드로 채운다."
        case .buildFloat: return "글라스에 빌드한 뒤 마지막 재료를 위에 띄운다."
        }
    }
}

// MARK: - Garnish

enum Garnish: String, CaseIterable, Codable, Identifiable {
    case none = "가니쉬 없음"
    case cherry = "Cherry (체리)"
    case greenOlive = "Green Olive (그린 올리브)"
    case lemonSlice = "A Slice of Lemon (레몬 슬라이스)"
    case limeOrLemonSlice = "A Slice of Lime or Lemon (라임/레몬 슬라이스)"
    case limeOrLemonWedge = "A Wedge of Lime or Lemon (라임/레몬 웨지)"
    case lemonPeelTwist = "Twist of Lemon Peel (레몬 필 트위스트)"
    case limeOrLemonPeelTwist = "Twist of Lime or Lemon Peel (라임/레몬 필 트위스트)"
    case orangePeelTwist = "Twist of Orange Peel (오렌지 필 트위스트)"
    case orangeSliceCherry = "A Slice of Orange & Cherry (오렌지 슬라이스 + 체리)"
    case lemonSliceCherry = "A Slice of Lemon & Cherry (레몬 슬라이스 + 체리)"
    case pineappleCherry = "A Wedge of Pineapple & Cherry (파인애플 웨지 + 체리)"
    case pineappleOrangeCherry = "A Wedge of Pineapple(Orange) & Cherry (파인애플(오렌지) 웨지 + 체리)"
    case appleSlice = "A Slice of Apple (사과 슬라이스)"
    case saltRim = "Rimming with Salt (소금 리밍)"
    case nutmeg = "Nutmeg Powder (넛맥 파우더)"
    // Distractors — not used by any official recipe
    case sugarRim = "Rimming with Sugar (설탕 리밍)"
    case orangeSlice = "A Slice of Orange (오렌지 슬라이스)"
    case mintSprig = "Mint Sprig (민트 잎)"
    case celeryStick = "Celery Stick (셀러리)"

    var id: String { rawValue }
}

// MARK: - Amount

enum Amount: String, CaseIterable, Codable, Identifiable {
    case quarterOz = "1/4 oz"
    case thirdOz = "1/3 oz"
    case halfOz = "1/2 oz"
    case threeQuarterOz = "3/4 oz"
    case oneOz = "1 oz"
    case oneQuarterOz = "1 1/4 oz"
    case oneHalfOz = "1 1/2 oz"
    case oneThreeQuarterOz = "1 3/4 oz"
    case twoOz = "2 oz"
    case twoHalfOz = "2 1/2 oz"
    case threeOz = "3 oz"
    case halfTsp = "1/2 tsp"
    case oneTsp = "1 tsp"
    case twoTsp = "2 tsp"
    case oneDash = "1 dash"
    case thirdPart = "1/3 part"
    case fill = "Fill"
    case halfPiece = "1/2 ea"

    var id: String { rawValue }
}

// MARK: - Ingredients

enum IngredientCategory: String, CaseIterable, Identifiable {
    case spirit = "기주 (스피릿)"
    case korean = "전통주"
    case wineBitters = "와인 · 베르무트 · 비터"
    case liqueur = "리큐르"
    case juiceMixer = "주스 · 믹서"
    case other = "시럽 · 설탕 · 기타"

    var id: String { rawValue }
}

enum Ingredient: String, CaseIterable, Codable, Identifiable {
    // Spirits
    case bourbon = "Bourbon Whiskey"
    case scotch = "Scotch Whisky"
    case irishWhiskey = "Irish Whiskey"
    case brandy = "Brandy"
    case appleBrandy = "Apple Brandy"
    case vodka = "Vodka"
    case dryGin = "Dry Gin"
    case sloeGin = "Sloe Gin"
    case lightRum = "Light Rum"
    case bacardiRum = "Bacardi Rum (White)"
    case darkRum = "Dark Rum"
    case tequila = "Tequila"
    // Korean traditional
    case gamhongro = "감홍로 (40도)"
    case jindoHongju = "진도 홍주 (40도)"
    case andongSoju = "안동 소주 (35도)"
    case geumsanInsamju = "금산 인삼주 (43도)"
    case bokbunja = "선운산 복분자주"
    // Wine / vermouth / bitters
    case whiteWine = "White Wine"
    case sweetVermouth = "Sweet Vermouth"
    case dryVermouth = "Dry Vermouth"
    case campari = "Campari"
    case angostura = "Angostura Bitters"
    // Liqueurs
    case drambuie = "Drambuie"
    case tripleSec = "Triple Sec (Cointreau)"
    case benedictine = "Benedictine DOM"
    case cremeDeCacaoBrown = "Crème de Cacao (Brown)"
    case cremeDeCacaoWhite = "Crème de Cacao (White)"
    case cremeDeMentheGreen = "Crème de Menthe (Green)"
    case cremeDeMentheWhite = "Crème de Menthe (White)"
    case cremeDeCassis = "Crème de Cassis"
    case coffeeLiqueur = "Coffee Liqueur (Kahlúa)"
    case baileys = "Bailey's Irish Cream"
    case grandMarnier = "Grand Marnier"
    case galliano = "Galliano"
    case applePucker = "Apple Pucker"
    case blueCuracao = "Blue Curaçao"
    case coconutRum = "Coconut Flavored Rum (Malibu)"
    case midori = "Melon Liqueur (Midori)"
    case bananaLiqueur = "Banana Liqueur"
    case peachLiqueur = "Peach Liqueur"
    case apricotBrandy = "Apricot Flavored Brandy"
    case cherryBrandy = "Cherry Flavored Brandy"
    case pinaColadaMix = "Piña Colada Mix"
    // Juices / mixers
    case limeJuice = "Lime Juice"
    case lemonJuice = "Lemon Juice"
    case orangeJuice = "Orange Juice"
    case pineappleJuice = "Pineapple Juice"
    case cranberryJuice = "Cranberry Juice"
    case grapefruitJuice = "Grapefruit Juice"
    case greenGrapeJuice = "White Grape Juice (청포도)"
    case tomatoJuice = "Tomato Juice"
    case sweetSourMix = "Sweet & Sour Mix"
    case milk = "Light Milk"
    case gingerAle = "Ginger Ale"
    case cola = "Cola"
    case sodaWater = "Soda Water"
    case sprite = "Sprite"
    case tonicWater = "Tonic Water"
    case freshLemon = "Fresh Squeezed Lemon"
    // Syrups / other
    case grenadine = "Grenadine Syrup"
    case raspberrySyrup = "Raspberry Syrup"
    case powderedSugar = "Powdered Sugar"
    case cubedSugar = "Cubed Sugar"

    var id: String { rawValue }

    var koreanName: String {
        switch self {
        case .bourbon: return "버번 위스키"
        case .scotch: return "스카치 위스키"
        case .irishWhiskey: return "아이리시 위스키"
        case .brandy: return "브랜디"
        case .appleBrandy: return "애플 브랜디"
        case .vodka: return "보드카"
        case .dryGin: return "드라이 진"
        case .sloeGin: return "슬로 진"
        case .lightRum: return "라이트 럼 (화이트 럼)"
        case .bacardiRum: return "바카디 화이트 럼"
        case .darkRum: return "다크 럼"
        case .tequila: return "데킬라"
        case .gamhongro: return "감홍로"
        case .jindoHongju: return "진도 홍주"
        case .andongSoju: return "안동 소주"
        case .geumsanInsamju: return "금산 인삼주"
        case .bokbunja: return "선운산 복분자주"
        case .whiteWine: return "화이트 와인"
        case .sweetVermouth: return "스위트 베르무트"
        case .dryVermouth: return "드라이 베르무트"
        case .campari: return "캄파리"
        case .angostura: return "앙고스투라 비터스"
        case .drambuie: return "드람뷔"
        case .tripleSec: return "트리플 섹 (쿠앵트로)"
        case .benedictine: return "베네딕틴 D.O.M"
        case .cremeDeCacaoBrown: return "크렘 드 카카오 (브라운)"
        case .cremeDeCacaoWhite: return "크렘 드 카카오 (화이트)"
        case .cremeDeMentheGreen: return "크렘 드 민트 (그린)"
        case .cremeDeMentheWhite: return "크렘 드 민트 (화이트)"
        case .cremeDeCassis: return "크렘 드 카시스"
        case .coffeeLiqueur: return "커피 리큐르 (깔루아)"
        case .baileys: return "베일리스"
        case .grandMarnier: return "그랑 마니에"
        case .galliano: return "갈리아노"
        case .applePucker: return "애플 퍼커"
        case .blueCuracao: return "블루 큐라소"
        case .coconutRum: return "코코넛 럼 (말리부)"
        case .midori: return "멜론 리큐르 (미도리)"
        case .bananaLiqueur: return "바나나 리큐르"
        case .peachLiqueur: return "피치 리큐르"
        case .apricotBrandy: return "애프리콧 브랜디"
        case .cherryBrandy: return "체리 브랜디"
        case .pinaColadaMix: return "피냐 콜라다 믹스"
        case .limeJuice: return "라임 주스"
        case .lemonJuice: return "레몬 주스"
        case .orangeJuice: return "오렌지 주스"
        case .pineappleJuice: return "파인애플 주스"
        case .cranberryJuice: return "크랜베리 주스"
        case .grapefruitJuice: return "자몽 주스"
        case .greenGrapeJuice: return "청포도 주스"
        case .tomatoJuice: return "토마토 주스"
        case .sweetSourMix: return "스위트 & 사워 믹스"
        case .milk: return "우유"
        case .gingerAle: return "진저 에일"
        case .cola: return "콜라"
        case .sodaWater: return "소다수 (탄산수)"
        case .sprite: return "스프라이트"
        case .tonicWater: return "토닉 워터"
        case .freshLemon: return "생레몬 착즙"
        case .grenadine: return "그레나딘 시럽"
        case .raspberrySyrup: return "라즈베리 시럽"
        case .powderedSugar: return "설탕 (파우더)"
        case .cubedSugar: return "각설탕"
        }
    }

    var category: IngredientCategory {
        switch self {
        case .bourbon, .scotch, .irishWhiskey, .brandy, .appleBrandy, .vodka, .dryGin, .sloeGin,
             .lightRum, .bacardiRum, .darkRum, .tequila:
            return .spirit
        case .gamhongro, .jindoHongju, .andongSoju, .geumsanInsamju, .bokbunja:
            return .korean
        case .whiteWine, .sweetVermouth, .dryVermouth, .campari, .angostura:
            return .wineBitters
        case .drambuie, .tripleSec, .benedictine, .cremeDeCacaoBrown, .cremeDeCacaoWhite,
             .cremeDeMentheGreen, .cremeDeMentheWhite, .cremeDeCassis, .coffeeLiqueur, .baileys,
             .grandMarnier, .galliano, .applePucker, .blueCuracao, .coconutRum, .midori,
             .bananaLiqueur, .peachLiqueur, .apricotBrandy, .cherryBrandy, .pinaColadaMix:
            return .liqueur
        case .limeJuice, .lemonJuice, .orangeJuice, .pineappleJuice, .cranberryJuice,
             .grapefruitJuice, .greenGrapeJuice, .tomatoJuice, .sweetSourMix, .milk, .gingerAle,
             .cola, .sodaWater, .sprite, .tonicWater, .freshLemon:
            return .juiceMixer
        case .grenadine, .raspberrySyrup, .powderedSugar, .cubedSugar:
            return .other
        }
    }
}

// MARK: - Recipe

struct RecipeItem: Codable, Hashable {
    let ingredient: Ingredient
    let amount: Amount
    /// Optional note shown in the recipe, e.g. "on top", "float".
    var note: String? = nil
}

struct Cocktail: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let englishName: String
    let base: Base
    let glass: Glass
    let method: Method
    let items: [RecipeItem]
    let garnish: Garnish
    var tip: String? = nil
}
