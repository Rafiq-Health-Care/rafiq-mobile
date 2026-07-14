enum MedicineBulkActionsEnum {
  delete,
  moveToGroup,
  markActive,
  markInactive;

  String get bulkActionStr {
    switch (this) {
      case MedicineBulkActionsEnum.delete:
        return 'DELETE';
      case MedicineBulkActionsEnum.moveToGroup:
        return 'MOVE_TO_GROUP';
      case MedicineBulkActionsEnum.markActive:
        return 'MARK_ACTIVE';
      case MedicineBulkActionsEnum.markInactive:
        return 'MARK_INACTIVE';
    }
  }
}
