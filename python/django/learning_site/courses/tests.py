from django.test import TestCase
from django.utils import timezone

# Create your tests here.
from .models import Course, Step

class CourseModelTests(TestCase):
    def test_course_creation(self):
        course = Course.objects.create(
            title="Python Regular Expressions",
            description="Learn to write regular expressions in Python"
        )
        now = timezone.now()
        self.assertLess(course.created_at, now)

class StepModelTests(TestCase):
    def test_step_creation(self):
        course = Course.objects.create(
            title="Python Regular Expressions",
            description="Learn to write regular expressions in Python"
        )

        step = Step.objects.create(
            title="Step 1",
            description="This is step 1",
            course = course
        )
        now = timezone.now()
        self.assertLess(step.course.created_at, now)