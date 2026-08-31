## Databricks VACUUM Command Guide

## Databricks VACUUM Command - Beginner Guide

## What is VACUUM in Databricks?

VACUUM is a Delta Lake maintenance command that removes old, unused, or deleted data files from a Delta table. Delta Lake keeps old versions of data for time travel and reliability, but these old files increase storage costs.

VACUUM = Cleanup of stale data files

## Why VACUUM is Needed

Delta tables keep old files because of:

- Time travel

- Rollbacks

- Streaming jobs

- ACID transactions

Over time, these old files become unnecessary. VACUUM safely removes them.

## Default Behavior

- Deletes files older than 7 days

- Keeps newer files for time travel

- Only removes files no longer referenced in the Delta log

## Basic VACUUM Example

## VACUUM sales_data;

Cleans up old files older than 7 days.

## Custom Retention Example

## VACUUM sales_data RETAIN 24 HOURS;

Keeps only 1 day of history.

After this, time travel beyond 24 hours is not possible.


DRY RUN Example (Safe Mode)

## VACUUM sales_data DRY RUN;

Shows which files would be deleted - without deleting anything.

FULL Cleanup Example

## VACUUM sales_data FULL;

Performs deeper cleanup (Databricks Runtime 16.1+).

## When to Use VACUUM

Use VACUUM when:

- Storage size is growing

- You dont need long time travel

- You frequently delete/update data

- You want to reduce cloud storage cost

## When NOT to Use VACUUM

## Avoid VACUUM if:

- You need long time travel (older than 7 days)

- You have long-running streaming jobs

- Pipelines depend on older versions

## Real-World Scenario

You store daily logs in a Delta table. You delete logs older than 3 days, but old files still remain. Run:

## VACUUM logs_table RETAIN 72 HOURS;

## Now:

- You keep 3 days of history

- Older files are removed

- Storage cost decreases


Beginner Tip

## Always run DRY RUN first:

VACUUM table_name DRY RUN;

This prevents accidental deletion of important files.
