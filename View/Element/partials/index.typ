<section class="clearfix">
	<a href="#/add" class="btn btn-success">Add</a>

	<p>Display a list of armies related to that user</p>
	<table class='table table-striped table-bordered table-listings'>
		<tr>
			<th><?php echo $this->Html->__t('Name'); ?></th>
			<th><?php echo $this->Html->__t('Description'); ?></th>
			<th><?php echo $this->Html->__t('Point Limit'); ?></th>
			<th><?php echo $this->Html->__t('Hidden'); ?></th>
			<th><?php echo $this->Html->__t('Created'); ?></th>
			<th><?php echo $this->Html->__t('Modified'); ?></th>
			<th><?php echo $this->Html->__t('Actions'); ?></th>
		</tr>

		<tr ng-repeat="army in my_armies" id="myarmy_{{army.id}}">
			<td>{{army.name}}</td>
			<td>{{army.descr | truncate:50}}</td>
			<td>{{army.point_limit}}</td>
			<td>{{army.hide}}</td>
			<td>{{dateMomment(army.created)}}</td>
			<td>{{dateMomment(army.modified)}}</td>
			<td class="actions">
				<a href="#/view/{{army.id}}" class="btn-sm btn-primary">View</a>
				<a href="#/edit/{{army.id}}" class="btn-sm btn-warning">Edit</a>
				<a href="#/setup/{{army.id}}" class="btn-sm btn-info">Setup</a>

				<a href="#/" class="btn-sm btn-danger" ng-confirm-click="Are you sure you want to delete this army?" confirmed-click="{{army.id}}">Delete</a>
			</td>
		</tr>
	</table>

	<p>Display a list of armies that people have submitted and opened for the public</p>
	<table class='table table-striped table-bordered table-listings'>
		<tr>
			<th><?php echo $this->Html->__t('Name'); ?></th>
			<th><?php echo $this->Html->__t('Description'); ?></th>
			<th><?php echo $this->Html->__t('Point Limit'); ?></th>
			<th><?php echo $this->Html->__t('Hidden'); ?></th>
			<th><?php echo $this->Html->__t('Created'); ?></th>
			<th><?php echo $this->Html->__t('Modified'); ?></th>
			<th><?php echo $this->Html->__t('Actions'); ?></th>
		</tr>

		<tr ng-repeat="army in all_armies">
			<td>{{army.name}}</td>
			<td>{{army.descr | truncate:50}}</td>
			<td>{{army.point_limit}}</td>
			<td>{{army.hide}}</td>
			<td>{{dateMomment(army.created)}}</td>
			<td>{{dateMomment(army.modified)}}</td>
			<td class="actions">
				<a href="#/view/{{army.code}}" class="btn-sm btn-primary">View</a>
			</td>
		</tr>
	</table>
</section>