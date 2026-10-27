import Foundation

/// 2025 NCS 기준 조주기능사 실기 표준 레시피 40종.
/// Amounts follow the official oz notation. 1 oz = 30 mL.
enum CocktailData {

    static let all: [Cocktail] = [

        // MARK: Whiskey base
        Cocktail(id: "manhattan", name: "맨해튼", englishName: "Manhattan", base: .whiskey,
                 glass: .cocktail, method: .stir,
                 items: [.init(ingredient: .bourbon, amount: .oneHalfOz),
                         .init(ingredient: .sweetVermouth, amount: .threeQuarterOz),
                         .init(ingredient: .angostura, amount: .oneDash)],
                 garnish: .cherry),

        Cocktail(id: "old-fashioned", name: "올드 패션드", englishName: "Old Fashioned", base: .whiskey,
                 glass: .oldFashioned, method: .build,
                 items: [.init(ingredient: .bourbon, amount: .oneHalfOz),
                         .init(ingredient: .powderedSugar, amount: .oneTsp),
                         .init(ingredient: .angostura, amount: .oneDash),
                         .init(ingredient: .sodaWater, amount: .halfOz)],
                 garnish: .orangeSliceCherry,
                 tip: "설탕·비터스·소다수를 먼저 넣고 녹인 뒤 얼음과 버번을 넣는다."),

        Cocktail(id: "new-york", name: "뉴욕", englishName: "New York", base: .whiskey,
                 glass: .cocktail, method: .shake,
                 items: [.init(ingredient: .bourbon, amount: .oneHalfOz),
                         .init(ingredient: .limeJuice, amount: .halfOz),
                         .init(ingredient: .powderedSugar, amount: .oneTsp),
                         .init(ingredient: .grenadine, amount: .halfTsp)],
                 garnish: .lemonPeelTwist),

        Cocktail(id: "whiskey-sour", name: "위스키 사워", englishName: "Whiskey Sour", base: .whiskey,
                 glass: .sour, method: .shakeBuild,
                 items: [.init(ingredient: .bourbon, amount: .oneHalfOz),
                         .init(ingredient: .lemonJuice, amount: .halfOz),
                         .init(ingredient: .powderedSugar, amount: .oneTsp),
                         .init(ingredient: .sodaWater, amount: .oneOz, note: "on top")],
                 garnish: .lemonSliceCherry),

        Cocktail(id: "boulevardier", name: "불바디에", englishName: "Boulevardier", base: .whiskey,
                 glass: .oldFashioned, method: .stir,
                 items: [.init(ingredient: .bourbon, amount: .oneOz),
                         .init(ingredient: .sweetVermouth, amount: .oneOz),
                         .init(ingredient: .campari, amount: .oneOz)],
                 garnish: .orangePeelTwist,
                 tip: "네그로니의 진을 버번으로 바꾼 구성. 글라스는 올드 패션드, 기법은 스터."),

        Cocktail(id: "rusty-nail", name: "러스티 네일", englishName: "Rusty Nail", base: .whiskey,
                 glass: .oldFashioned, method: .build,
                 items: [.init(ingredient: .scotch, amount: .oneOz),
                         .init(ingredient: .drambuie, amount: .halfOz)],
                 garnish: .none),

        // MARK: Brandy base
        Cocktail(id: "sidecar", name: "사이드카", englishName: "Sidecar", base: .brandy,
                 glass: .cocktail, method: .shake,
                 items: [.init(ingredient: .brandy, amount: .oneOz),
                         .init(ingredient: .tripleSec, amount: .oneOz),
                         .init(ingredient: .lemonJuice, amount: .quarterOz)],
                 garnish: .none),

        Cocktail(id: "brandy-alexander", name: "브랜디 알렉산더", englishName: "Brandy Alexander", base: .brandy,
                 glass: .cocktail, method: .shake,
                 items: [.init(ingredient: .brandy, amount: .threeQuarterOz),
                         .init(ingredient: .cremeDeCacaoBrown, amount: .threeQuarterOz),
                         .init(ingredient: .milk, amount: .threeQuarterOz)],
                 garnish: .nutmeg),

        Cocktail(id: "honeymoon", name: "허니문", englishName: "Honeymoon", base: .brandy,
                 glass: .cocktail, method: .shake,
                 items: [.init(ingredient: .appleBrandy, amount: .threeQuarterOz),
                         .init(ingredient: .benedictine, amount: .threeQuarterOz),
                         .init(ingredient: .tripleSec, amount: .quarterOz),
                         .init(ingredient: .lemonJuice, amount: .halfOz)],
                 garnish: .none),

        // MARK: Vodka base
        Cocktail(id: "black-russian", name: "블랙 러시안", englishName: "Black Russian", base: .vodka,
                 glass: .oldFashioned, method: .build,
                 items: [.init(ingredient: .vodka, amount: .oneOz),
                         .init(ingredient: .coffeeLiqueur, amount: .halfOz)],
                 garnish: .none),

        Cocktail(id: "moscow-mule", name: "모스코 뮬", englishName: "Moscow Mule", base: .vodka,
                 glass: .highball, method: .build,
                 items: [.init(ingredient: .vodka, amount: .oneHalfOz),
                         .init(ingredient: .limeJuice, amount: .halfOz),
                         .init(ingredient: .gingerAle, amount: .fill)],
                 garnish: .limeOrLemonSlice),

        Cocktail(id: "sea-breeze", name: "씨 브리즈", englishName: "Sea Breeze", base: .vodka,
                 glass: .highball, method: .build,
                 items: [.init(ingredient: .vodka, amount: .oneHalfOz),
                         .init(ingredient: .cranberryJuice, amount: .threeOz),
                         .init(ingredient: .grapefruitJuice, amount: .halfOz)],
                 garnish: .limeOrLemonWedge),

        Cocktail(id: "cosmopolitan", name: "코스모폴리탄", englishName: "Cosmopolitan", base: .vodka,
                 glass: .cocktail, method: .shake,
                 items: [.init(ingredient: .vodka, amount: .oneOz),
                         .init(ingredient: .tripleSec, amount: .halfOz),
                         .init(ingredient: .limeJuice, amount: .halfOz),
                         .init(ingredient: .cranberryJuice, amount: .halfOz)],
                 garnish: .limeOrLemonPeelTwist),

        Cocktail(id: "apple-martini", name: "애플 마티니", englishName: "Apple Martini", base: .vodka,
                 glass: .cocktail, method: .shake,
                 items: [.init(ingredient: .vodka, amount: .oneOz),
                         .init(ingredient: .applePucker, amount: .oneOz),
                         .init(ingredient: .limeJuice, amount: .halfOz)],
                 garnish: .appleSlice),

        // MARK: Gin base
        Cocktail(id: "dry-martini", name: "드라이 마티니", englishName: "Dry Martini", base: .gin,
                 glass: .cocktail, method: .stir,
                 items: [.init(ingredient: .dryGin, amount: .twoOz),
                         .init(ingredient: .dryVermouth, amount: .thirdOz)],
                 garnish: .greenOlive),

        Cocktail(id: "negroni", name: "네그로니", englishName: "Negroni", base: .gin,
                 glass: .oldFashioned, method: .build,
                 items: [.init(ingredient: .dryGin, amount: .threeQuarterOz),
                         .init(ingredient: .sweetVermouth, amount: .threeQuarterOz),
                         .init(ingredient: .campari, amount: .threeQuarterOz)],
                 garnish: .lemonPeelTwist),

        Cocktail(id: "singapore-sling", name: "싱가포르 슬링", englishName: "Singapore Sling", base: .gin,
                 glass: .footedPilsner, method: .shakeBuild,
                 items: [.init(ingredient: .dryGin, amount: .oneHalfOz),
                         .init(ingredient: .lemonJuice, amount: .halfOz),
                         .init(ingredient: .powderedSugar, amount: .oneTsp),
                         .init(ingredient: .sodaWater, amount: .fill),
                         .init(ingredient: .cherryBrandy, amount: .halfOz, note: "on top")],
                 garnish: .orangeSliceCherry),

        Cocktail(id: "gin-fizz", name: "진 피즈", englishName: "Gin Fizz", base: .gin,
                 glass: .highball, method: .shakeBuild,
                 items: [.init(ingredient: .dryGin, amount: .oneHalfOz),
                         .init(ingredient: .lemonJuice, amount: .halfOz),
                         .init(ingredient: .powderedSugar, amount: .oneTsp),
                         .init(ingredient: .sodaWater, amount: .fill)],
                 garnish: .lemonSlice),

        Cocktail(id: "long-island-iced-tea", name: "롱 아일랜드 아이스 티", englishName: "Long Island Iced Tea", base: .gin,
                 glass: .collins, method: .build,
                 items: [.init(ingredient: .dryGin, amount: .halfOz),
                         .init(ingredient: .vodka, amount: .halfOz),
                         .init(ingredient: .lightRum, amount: .halfOz),
                         .init(ingredient: .tequila, amount: .halfOz),
                         .init(ingredient: .tripleSec, amount: .halfOz),
                         .init(ingredient: .sweetSourMix, amount: .oneHalfOz),
                         .init(ingredient: .cola, amount: .fill)],
                 garnish: .limeOrLemonWedge),

        // MARK: Rum base
        Cocktail(id: "daiquiri", name: "다이키리", englishName: "Daiquiri", base: .rum,
                 glass: .cocktail, method: .shake,
                 items: [.init(ingredient: .lightRum, amount: .oneThreeQuarterOz),
                         .init(ingredient: .limeJuice, amount: .threeQuarterOz),
                         .init(ingredient: .powderedSugar, amount: .oneTsp)],
                 garnish: .none),

        Cocktail(id: "bacardi", name: "바카디", englishName: "Bacardi", base: .rum,
                 glass: .cocktail, method: .shake,
                 items: [.init(ingredient: .bacardiRum, amount: .oneThreeQuarterOz),
                         .init(ingredient: .limeJuice, amount: .threeQuarterOz),
                         .init(ingredient: .grenadine, amount: .oneTsp)],
                 garnish: .none,
                 tip: "다이키리와 거의 같지만 설탕 대신 그레나딘, 럼은 '바카디' 브랜드 지정."),

        Cocktail(id: "cuba-libre", name: "쿠바 리브레", englishName: "Cuba Libre", base: .rum,
                 glass: .highball, method: .build,
                 items: [.init(ingredient: .lightRum, amount: .oneHalfOz),
                         .init(ingredient: .limeJuice, amount: .halfOz),
                         .init(ingredient: .cola, amount: .fill)],
                 garnish: .limeOrLemonWedge),

        Cocktail(id: "mai-tai", name: "마이 타이", englishName: "Mai-Tai", base: .rum,
                 glass: .footedPilsner, method: .blend,
                 items: [.init(ingredient: .lightRum, amount: .oneQuarterOz),
                         .init(ingredient: .tripleSec, amount: .threeQuarterOz),
                         .init(ingredient: .limeJuice, amount: .oneOz),
                         .init(ingredient: .pineappleJuice, amount: .oneOz),
                         .init(ingredient: .orangeJuice, amount: .oneOz),
                         .init(ingredient: .grenadine, amount: .quarterOz)],
                 garnish: .pineappleOrangeCherry),

        Cocktail(id: "pina-colada", name: "피냐 콜라다", englishName: "Piña Colada", base: .rum,
                 glass: .footedPilsner, method: .blend,
                 items: [.init(ingredient: .lightRum, amount: .oneQuarterOz),
                         .init(ingredient: .pinaColadaMix, amount: .twoOz),
                         .init(ingredient: .pineappleJuice, amount: .twoOz)],
                 garnish: .pineappleCherry),

        Cocktail(id: "blue-hawaiian", name: "블루 하와이안", englishName: "Blue Hawaiian", base: .rum,
                 glass: .footedPilsner, method: .blend,
                 items: [.init(ingredient: .lightRum, amount: .oneOz),
                         .init(ingredient: .blueCuracao, amount: .oneOz),
                         .init(ingredient: .coconutRum, amount: .oneOz),
                         .init(ingredient: .pineappleJuice, amount: .twoHalfOz)],
                 garnish: .pineappleCherry),

        // MARK: Tequila base
        Cocktail(id: "tequila-sunrise", name: "데킬라 선라이즈", englishName: "Tequila Sunrise", base: .tequila,
                 glass: .footedPilsner, method: .buildFloat,
                 items: [.init(ingredient: .tequila, amount: .oneHalfOz),
                         .init(ingredient: .orangeJuice, amount: .fill),
                         .init(ingredient: .grenadine, amount: .halfOz, note: "float")],
                 garnish: .none),

        Cocktail(id: "margarita", name: "마가리타", englishName: "Margarita", base: .tequila,
                 glass: .cocktail, method: .shake,
                 items: [.init(ingredient: .tequila, amount: .oneHalfOz),
                         .init(ingredient: .tripleSec, amount: .halfOz),
                         .init(ingredient: .limeJuice, amount: .halfOz)],
                 garnish: .saltRim,
                 tip: "40종 중 유일하게 리밍(프로스팅) 기법을 쓰는 칵테일."),

        // MARK: Liqueur base
        Cocktail(id: "apricot", name: "애프리콧", englishName: "Apricot", base: .liqueur,
                 glass: .cocktail, method: .shake,
                 items: [.init(ingredient: .apricotBrandy, amount: .oneHalfOz),
                         .init(ingredient: .dryGin, amount: .oneTsp),
                         .init(ingredient: .lemonJuice, amount: .halfOz),
                         .init(ingredient: .orangeJuice, amount: .halfOz)],
                 garnish: .none),

        Cocktail(id: "grasshopper", name: "그래스호퍼", englishName: "Grasshopper", base: .liqueur,
                 glass: .saucerChampagne, method: .shake,
                 items: [.init(ingredient: .cremeDeMentheGreen, amount: .oneOz),
                         .init(ingredient: .cremeDeCacaoWhite, amount: .oneOz),
                         .init(ingredient: .milk, amount: .oneOz)],
                 garnish: .none),

        Cocktail(id: "june-bug", name: "준 벅", englishName: "June Bug", base: .liqueur,
                 glass: .collins, method: .shake,
                 items: [.init(ingredient: .midori, amount: .oneOz),
                         .init(ingredient: .coconutRum, amount: .halfOz),
                         .init(ingredient: .bananaLiqueur, amount: .halfOz),
                         .init(ingredient: .pineappleJuice, amount: .twoOz),
                         .init(ingredient: .sweetSourMix, amount: .twoOz)],
                 garnish: .pineappleCherry),

        Cocktail(id: "pousse-cafe", name: "푸스 카페", englishName: "Pousse Café", base: .liqueur,
                 glass: .liqueur, method: .float,
                 items: [.init(ingredient: .grenadine, amount: .thirdPart),
                         .init(ingredient: .cremeDeMentheGreen, amount: .thirdPart),
                         .init(ingredient: .brandy, amount: .thirdPart)],
                 garnish: .none,
                 tip: "그레나딘 → 크렘 드 민트(그린) → 브랜디 순서로 띄운다."),

        Cocktail(id: "b-52", name: "B-52", englishName: "B-52", base: .liqueur,
                 glass: .sherry, method: .float,
                 items: [.init(ingredient: .coffeeLiqueur, amount: .thirdPart),
                         .init(ingredient: .baileys, amount: .thirdPart),
                         .init(ingredient: .grandMarnier, amount: .thirdPart)],
                 garnish: .none,
                 tip: "깔루아 → 베일리스 → 그랑 마니에 순서로 띄운다."),

        // MARK: Wine base
        Cocktail(id: "kir", name: "키르", englishName: "Kir", base: .wine,
                 glass: .whiteWine, method: .build,
                 items: [.init(ingredient: .whiteWine, amount: .threeOz),
                         .init(ingredient: .cremeDeCassis, amount: .halfOz)],
                 garnish: .lemonPeelTwist),

        // MARK: Korean traditional base
        Cocktail(id: "healing", name: "힐링", englishName: "Healing", base: .korean,
                 glass: .cocktail, method: .shake,
                 items: [.init(ingredient: .gamhongro, amount: .oneHalfOz),
                         .init(ingredient: .benedictine, amount: .thirdOz),
                         .init(ingredient: .cremeDeCassis, amount: .thirdOz),
                         .init(ingredient: .sweetSourMix, amount: .oneOz)],
                 garnish: .lemonPeelTwist),

        Cocktail(id: "jindo", name: "진도", englishName: "Jindo", base: .korean,
                 glass: .cocktail, method: .shake,
                 items: [.init(ingredient: .jindoHongju, amount: .oneOz),
                         .init(ingredient: .cremeDeMentheWhite, amount: .halfOz),
                         .init(ingredient: .greenGrapeJuice, amount: .threeQuarterOz),
                         .init(ingredient: .raspberrySyrup, amount: .halfOz)],
                 garnish: .none),

        Cocktail(id: "puppy-love", name: "풋사랑", englishName: "Puppy Love", base: .korean,
                 glass: .cocktail, method: .shake,
                 items: [.init(ingredient: .andongSoju, amount: .oneOz),
                         .init(ingredient: .tripleSec, amount: .thirdOz),
                         .init(ingredient: .applePucker, amount: .oneOz),
                         .init(ingredient: .limeJuice, amount: .thirdOz)],
                 garnish: .appleSlice),

        Cocktail(id: "geumsan", name: "금산", englishName: "Geumsan", base: .korean,
                 glass: .cocktail, method: .shake,
                 items: [.init(ingredient: .geumsanInsamju, amount: .oneHalfOz),
                         .init(ingredient: .coffeeLiqueur, amount: .halfOz),
                         .init(ingredient: .applePucker, amount: .halfOz),
                         .init(ingredient: .limeJuice, amount: .oneTsp)],
                 garnish: .none),

        Cocktail(id: "gochang", name: "고창", englishName: "Gochang", base: .korean,
                 glass: .fluteChampagne, method: .stir,
                 items: [.init(ingredient: .bokbunja, amount: .twoOz),
                         .init(ingredient: .tripleSec, amount: .halfOz),
                         .init(ingredient: .sprite, amount: .twoOz)],
                 garnish: .none),

        // MARK: Non-alcoholic
        Cocktail(id: "fresh-lemon-squash", name: "프레시 레몬 스쿼시", englishName: "Fresh Lemon Squash", base: .nonAlcoholic,
                 glass: .highball, method: .build,
                 items: [.init(ingredient: .freshLemon, amount: .halfPiece),
                         .init(ingredient: .powderedSugar, amount: .twoTsp),
                         .init(ingredient: .sodaWater, amount: .fill)],
                 garnish: .lemonSlice),

        Cocktail(id: "virgin-fruit-punch", name: "버진 프루트 펀치", englishName: "Virgin Fruit Punch", base: .nonAlcoholic,
                 glass: .footedPilsner, method: .blend,
                 items: [.init(ingredient: .orangeJuice, amount: .oneOz),
                         .init(ingredient: .pineappleJuice, amount: .oneOz),
                         .init(ingredient: .cranberryJuice, amount: .oneOz),
                         .init(ingredient: .grapefruitJuice, amount: .oneOz),
                         .init(ingredient: .lemonJuice, amount: .halfOz),
                         .init(ingredient: .grenadine, amount: .halfOz)],
                 garnish: .pineappleCherry),
    ]

    static func cocktail(id: String) -> Cocktail? {
        all.first { $0.id == id }
    }

    /// Picks `count` distinct random cocktails, mirroring the exam's 3-drink set.
    static func randomSet(count: Int = 3) -> [Cocktail] {
        Array(all.shuffled().prefix(count))
    }
}
