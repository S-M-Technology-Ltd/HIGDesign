import HIGComponents
import Testing

@Test
func instagramPhotosPickerConfigurationHonorsSingleSelectionLimit() {
    let configuration = HIGInstagramPhotosPickerConfiguration(
        selectionLimit: 10,
        allowsMultipleSelection: false
    )

    #expect(configuration.effectiveSelectionLimit == 1)
}

@Test
func instagramPhotosPickerConfigurationHonorsMultipleSelectionLimit() {
    let configuration = HIGInstagramPhotosPickerConfiguration(
        selectionLimit: 4,
        allowsMultipleSelection: true
    )

    #expect(configuration.effectiveSelectionLimit == 4)
}