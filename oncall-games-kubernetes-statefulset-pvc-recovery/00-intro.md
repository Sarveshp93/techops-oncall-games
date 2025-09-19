You’re on call for a stateful workload. Confirm that data written to a **PVC-backed** path persists across Pod deletion and scale-to-zero.

Tasks:
1. Write a marker file under `/data` (mounted PVC).
2. Delete the Pod and verify the marker remains.
3. Scale down to `0` then back to `1` and verify again.
