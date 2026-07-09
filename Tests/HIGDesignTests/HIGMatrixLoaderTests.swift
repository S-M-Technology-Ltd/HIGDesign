@testable import HIGComponents
import Testing

@Test
func matrixLoaderCatalogContainsExactly112Loaders() {
    #expect(HIGMatrixLoaderID.all.count == HIGMatrixLoaderID.catalogCount)
    #expect(HIGMatrixLoaderID.catalogCount == 112)
    #expect(HIGMatrixLoaderFun.allCases.count == 18)
}

@Test
func matrixLoaderFamilyRangesAreValid() {
    #expect((1...23).allSatisfy { HIGMatrixLoaderID.square($0).isValid })
    #expect((1...20).allSatisfy { HIGMatrixLoaderID.circular($0).isValid })
    #expect((1...10).allSatisfy { HIGMatrixLoaderID.hex($0).isValid })
    #expect((1...20).allSatisfy { HIGMatrixLoaderID.grid3($0).isValid })
    #expect((1...20).allSatisfy { HIGMatrixLoaderID.triangle($0).isValid })
    #expect(!HIGMatrixLoaderID.square(0).isValid)
    #expect(!HIGMatrixLoaderID.square(24).isValid)
    #expect(HIGMatrixLoaderID.square(99).clamped() == .square(23))
}

@Test
func matrixLoaderStyleMapsIntoCatalog() {
    for style in HIGMatrixLoaderStyle.allCases {
        #expect(style.loaderID.isValid)
        #expect(HIGMatrixLoaderID.all.contains(style.loaderID))
    }
}

@Test
func matrixLoaderSeedIsDeterministicAcrossCatalog() {
    let first = HIGMatrixLoaderID.resolved(fromSeed: "prep")
    let second = HIGMatrixLoaderID.resolved(fromSeed: "prep")
    #expect(first == second)
    #expect(HIGMatrixLoaderID.all.contains(first))
}

@Test
func matrixLoaderEveryRecipeProducesFiniteOpacity() {
    for id in HIGMatrixLoaderID.all {
        let recipe = HIGMatrixLoaderRecipe.recipe(for: id)
        #expect(recipe.gridCount >= 3)
        let mid = recipe.gridCount / 2
        let value = HIGMatrixLoaderGrid.opacity(
            id: id,
            row: mid,
            column: mid,
            phase: 0.33,
            base: 0.2,
            peak: 1,
            reduceMotion: false
        )
        #expect(value >= 0)
        #expect(value <= 1)

        let reduced = HIGMatrixLoaderGrid.opacity(
            id: id,
            row: mid,
            column: mid,
            phase: 0.33,
            base: 0.2,
            peak: 1,
            reduceMotion: true
        )
        #expect(reduced >= 0)
        #expect(reduced <= 1)
    }
}

@Test
func matrixLoaderCyclePhaseWrapsUnitInterval() {
    let phase = HIGMatrixLoaderGrid.cyclePhase(now: 2.5, cycleDuration: 1)
    #expect(phase >= 0)
    #expect(phase < 1)
}
