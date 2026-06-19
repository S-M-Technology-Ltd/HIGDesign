import HIGTokensComponent
import Testing

@Test
func checkboxTokensUseMinimumTouchHeight() {
    let tokens = HIGSystemCheckboxTokens()
    #expect(tokens.minHeight >= 44)
}

@Test
func radioTokensUseReadableSpacing() {
    let tokens = HIGSystemRadioTokens()
    #expect(tokens.optionSpacing >= 4)
    #expect(tokens.minHeight >= 44)
}

@Test
func segmentedControlTokensUseReadableMetrics() {
    let tokens = HIGSystemSegmentedControlTokens()
    #expect(tokens.minHeight >= 44)
    #expect(tokens.cornerRadius >= 4)
}

@Test
func sliderTokensUseVisibleTrackHeight() {
    let tokens = HIGSystemSliderTokens()
    #expect(tokens.trackHeight >= 2)
    #expect(tokens.minHeight >= 44)
}

@Test
func pickerTokensUseMinimumTouchHeight() {
    let tokens = HIGSystemPickerTokens()
    #expect(tokens.minHeight >= 44)
}