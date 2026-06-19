import HIGComponents
import Testing

@Test
@MainActor
func toastQueuePresentsMessagesSequentially() async {
    let queue = HIGToastQueue()
    queue.enqueue("First", duration: .milliseconds(200))
    #expect(queue.currentMessage == "First")

    queue.enqueue("Second", duration: .milliseconds(200))
    #expect(queue.currentMessage == "First")

    try? await Task.sleep(for: .milliseconds(250))
    #expect(queue.currentMessage == "Second")

    try? await Task.sleep(for: .milliseconds(250))
    #expect(queue.currentMessage == nil)
}