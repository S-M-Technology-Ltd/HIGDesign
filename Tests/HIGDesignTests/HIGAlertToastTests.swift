import HIGComponents
import HIGTokensComponent
import Testing

@Test
func alertTokensDefineModalWidth() {
    let tokens = HIGSystemAlertTokens()
    #expect(tokens.modalMaxWidth >= 280)
}

@Test
func toastTokensDefineDismissTarget() {
    let tokens = HIGSystemToastTokens()
    #expect(tokens.dismissButtonSize >= 20)
}

@Test
func toastQueueConfigurationDefinesPresets() {
    #expect(HIGToastQueueConfiguration.standard.allowsManualDismissal == false)
    #expect(HIGToastQueueConfiguration.interactive.allowsManualDismissal == true)
    #expect(HIGToastQueueConfiguration.interactive.maximumQueuedMessages >= 5)
}

@Test
@MainActor
func toastQueueRespectsMaximumQueuedMessages() async {
    let queue = HIGToastQueue(configuration: HIGToastQueueConfiguration(maximumQueuedMessages: 2))
    queue.enqueue("One", duration: .seconds(5))
    queue.enqueue("Two", duration: .seconds(5))
    queue.enqueue("Three", duration: .seconds(5))
    queue.enqueue("Four", duration: .seconds(5))

    #expect(queue.currentMessage == "One")
    queue.dismissCurrent()
    #expect(queue.currentMessage == "Three")
}

@Test
@MainActor
func toastQueueManualDismissalAdvancesQueue() async {
    let queue = HIGToastQueue(configuration: .interactive)
    queue.enqueue("First", duration: .seconds(5))
    queue.enqueue("Second", duration: .seconds(5))

    #expect(queue.currentMessage == "First")
    queue.dismissCurrent()
    #expect(queue.currentMessage == "Second")
}