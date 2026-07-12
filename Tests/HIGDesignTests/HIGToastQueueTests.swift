import HIGComponents
import Testing

@Test
@MainActor
func toastQueuePresentsMessagesSequentially() async {
    let queue = HIGToastQueue()
    queue.enqueue("First", style: .info, duration: .milliseconds(200))
    #expect(queue.currentMessage == "First")
    #expect(queue.current?.style == .info)

    queue.enqueue("Second", style: .success, duration: .milliseconds(200))
    #expect(queue.currentMessage == "First")

    try? await Task.sleep(for: .milliseconds(250))
    #expect(queue.currentMessage == "Second")
    #expect(queue.current?.style == .success)

    try? await Task.sleep(for: .milliseconds(250))
    #expect(queue.currentMessage == nil)
}