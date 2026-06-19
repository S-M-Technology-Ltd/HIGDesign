import HIGComponents
import Testing

@Test
func photoPickerConfigurationHonorsSingleSelectionLimit() {
    let configuration = HIGPhotoPickerConfiguration(
        selectionLimit: 10,
        allowsMultipleSelection: false
    )

    #expect(configuration.effectiveSelectionLimit == 1)
}

@Test
func photoPickerConfigurationHonorsMultipleSelectionLimit() {
    let configuration = HIGPhotoPickerConfiguration(
        selectionLimit: 4,
        allowsMultipleSelection: true
    )

    #expect(configuration.effectiveSelectionLimit == 4)
}